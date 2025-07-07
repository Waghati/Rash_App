use crate::models::user::{CreateUserRequest, LoginRequest, UserResponse};
use crate::services::auth_service::{AuthService, Claims};
use crate::utils::errors::{AppError, Result};
use crate::AppState;
use axum::{
    extract::{Extension, State},
    Json,
};
use serde_json::json;
use validator::Validate;

pub async fn register(
    State(state): State<AppState>,
    Json(request): Json<CreateUserRequest>,
) -> Result<Json<serde_json::Value>> {
    // Validate request
    request.validate()
        .map_err(|e| AppError::ValidationError(format!("Validation failed: {}", e)))?;

    let auth_service = AuthService::new(
        state.db.clone(),
        state.config.jwt_secret.clone(),
        state.config.jwt_expiration,
    );

    let user = auth_service.register_user(request).await?;

    Ok(Json(json!({
        "message": "User created successfully",
        "user": user
    })))
}

pub async fn login(
    State(state): State<AppState>,
    Json(request): Json<LoginRequest>,
) -> Result<Json<serde_json::Value>> {
    // Validate request
    request.validate()
        .map_err(|e| AppError::ValidationError(format!("Validation failed: {}", e)))?;

    let auth_service = AuthService::new(
        state.db.clone(),
        state.config.jwt_secret.clone(),
        state.config.jwt_expiration,
    );

    let (token, user) = auth_service.login(request).await?;

    Ok(Json(json!({
        "message": "Login successful",
        "token": token,
        "user": user
    })))
}

pub async fn me(
    State(state): State<AppState>,
    Extension(claims): Extension<Claims>,
) -> Result<Json<UserResponse>> {
    let auth_service = AuthService::new(
        state.db.clone(),
        state.config.jwt_secret.clone(),
        state.config.jwt_expiration,
    );

    let user = auth_service.get_user_by_id(claims.sub).await?;
    Ok(Json(user.into()))
}