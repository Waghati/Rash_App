use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use uuid::Uuid;
use chrono::{DateTime, Utc};
use validator::Validate;

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct User {
    pub id: Uuid,
    pub email: String,
    #[serde(skip_serializing)] // Don't include password in JSON responses
    pub password_hash: String,
    pub name: String,
    pub user_type: String,
    pub profile_image: Option<String>,
    pub created_at: Option<DateTime<Utc>>, // Make these Optional
    pub updated_at: Option<DateTime<Utc>>, // Make these Optional
    pub metadata: Option<serde_json::Value>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct Student {
    pub id: Uuid,
    pub grade: String,
    pub subjects: Vec<String>,
    pub parent_id: Option<Uuid>,
    pub school_id: Option<Uuid>,
    pub moodle_user_id: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct Teacher {
    pub id: Uuid,
    pub subjects: Vec<String>,
    pub grades: Vec<String>,
    pub school_id: Option<Uuid>,
    pub department: Option<String>,
    pub moodle_user_id: Option<i32>,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct Parent {
    pub id: Uuid,
    pub children_ids: Vec<Uuid>,
    pub occupation: Option<String>,
}

#[derive(Debug, Deserialize, Validate)]
pub struct CreateUserRequest {
    #[validate(email)]
    pub email: String,
    #[validate(length(min = 8))]
    pub password: String,
    #[validate(length(min = 2))]
    pub name: String,
    pub user_type: String,
}

#[derive(Debug, Deserialize, Validate)]
pub struct LoginRequest {
    #[validate(email)]
    pub email: String,
    pub password: String,
}

#[derive(Debug, Serialize)]
pub struct UserResponse {
    pub id: Uuid,
    pub email: String,
    pub name: String,
    pub user_type: String,
    pub profile_image: Option<String>,
    pub created_at: Option<DateTime<Utc>>,
}

impl From<User> for UserResponse {
    fn from(user: User) -> Self {
        UserResponse {
            id: user.id,
            email: user.email,
            name: user.name,
            user_type: user.user_type,
            profile_image: user.profile_image,
            created_at: user.created_at,
        }
    }
}