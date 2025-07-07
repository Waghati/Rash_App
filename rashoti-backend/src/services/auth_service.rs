use crate::models::user::{User, CreateUserRequest, LoginRequest, UserResponse};
use crate::utils::errors::{AppError, Result};
use sqlx::PgPool;
use uuid::Uuid;
use bcrypt::{hash, verify, DEFAULT_COST};
use jsonwebtoken::{encode, decode, Header, Validation, EncodingKey, DecodingKey};
use serde::{Serialize, Deserialize};
use chrono::Utc;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Claims {
    pub sub: Uuid,
    pub email: String,
    pub user_type: String,
    pub exp: usize,
}

pub struct AuthService {
    db: PgPool,
    jwt_secret: String,
    jwt_expiration: u64,
}

impl AuthService {
    pub fn new(db: PgPool, jwt_secret: String, jwt_expiration: u64) -> Self {
        Self {
            db,
            jwt_secret,
            jwt_expiration,
        }
    }

    pub async fn register_user(&self, request: CreateUserRequest) -> Result<UserResponse> {
        // Check if user already exists
        let existing_user = sqlx::query!("SELECT id FROM users WHERE email = $1", request.email)
            .fetch_optional(&self.db)
            .await?;

        if existing_user.is_some() {
            return Err(AppError::ValidationError("User already exists".to_string()));
        }

        // Hash password
        let password_hash = hash(request.password, DEFAULT_COST)
            .map_err(|e| AppError::InternalServerError(format!("Password hashing failed: {}", e)))?;

        // Create user
        let user_id = Uuid::new_v4();
        let now = Utc::now();

        sqlx::query!(
            r#"
            INSERT INTO users (id, email, password_hash, name, user_type, created_at, updated_at)
            VALUES ($1, $2, $3, $4, $5, $6, $7)
            "#,
            user_id,
            request.email,
            password_hash,
            request.name,
            request.user_type,
            now,
            now
        )
        .execute(&self.db)
        .await?;

        // Create role-specific record
        match request.user_type.as_str() {
            "student" => {
                sqlx::query!(
                    "INSERT INTO students (id, grade, subjects) VALUES ($1, $2, $3)",
                    user_id,
                    "Not Set",
                    &[] as &[String]
                )
                .execute(&self.db)
                .await?;
            }
            "teacher" => {
                sqlx::query!(
                    "INSERT INTO teachers (id, subjects, grades) VALUES ($1, $2, $3)",
                    user_id,
                    &[] as &[String],
                    &[] as &[String]
                )
                .execute(&self.db)
                .await?;
            }
            "parent" => {
                sqlx::query!(
                    "INSERT INTO parents (id, children_ids) VALUES ($1, $2)",
                    user_id,
                    &[] as &[Uuid]
                )
                .execute(&self.db)
                .await?;
            }
            _ => return Err(AppError::ValidationError("Invalid user type".to_string())),
        }

        let user = self.get_user_by_id(user_id).await?;
        Ok(user.into())
    }

    pub async fn login(&self, request: LoginRequest) -> Result<(String, UserResponse)> {
        let user = sqlx::query_as!(
            User,
            "SELECT * FROM users WHERE email = $1",
            request.email
        )
        .fetch_optional(&self.db)
        .await?
        .ok_or_else(|| AppError::AuthenticationError("Invalid credentials".to_string()))?;

        if !verify(&request.password, &user.password_hash)
            .map_err(|e| AppError::InternalServerError(format!("Password verification failed: {}", e)))?
        {
            return Err(AppError::AuthenticationError("Invalid credentials".to_string()));
        }

        let token = self.create_jwt(&user)?;
        Ok((token, user.into()))
    }

    pub async fn get_user_by_id(&self, id: Uuid) -> Result<User> {
        let user = sqlx::query_as!(User, "SELECT * FROM users WHERE id = $1", id)
            .fetch_optional(&self.db)
            .await?
            .ok_or_else(|| AppError::NotFound("User not found".to_string()))?;

        Ok(user)
    }

    pub fn create_jwt(&self, user: &User) -> Result<String> {
        let expiration = chrono::Utc::now()
            .checked_add_signed(chrono::Duration::seconds(self.jwt_expiration as i64))
            .expect("valid timestamp")
            .timestamp();

        let claims = Claims {
            sub: user.id,
            email: user.email.clone(),
            user_type: user.user_type.clone(),
            exp: expiration as usize,
        };

        encode(
            &Header::default(),
            &claims,
            &EncodingKey::from_secret(self.jwt_secret.as_ref()),
        )
        .map_err(|e| AppError::InternalServerError(format!("JWT creation failed: {}", e)))
    }

    pub fn validate_jwt(&self, token: &str) -> Result<Claims> {
        decode::<Claims>(
            token,
            &DecodingKey::from_secret(self.jwt_secret.as_ref()),
            &Validation::default(),
        )
        .map(|data| data.claims)
        .map_err(|e| AppError::AuthenticationError(format!("Invalid token: {}", e)))
    }
}