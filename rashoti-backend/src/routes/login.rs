use axum::{Json, response::IntoResponse};
use serde::Deserialize;
use crate::auth::jwt::create_jwt;

#[derive(Deserialize)]
pub struct LoginRequest {
    username: String,
    password: String,
}

pub async fn login(Json(payload): Json<LoginRequest>) -> impl IntoResponse {
    if payload.username == "student" && payload.password == "1234" {
        let token = create_jwt(&payload.username);
        Json(serde_json::json!({ "token": token }))
    } else {
        (axum::http::StatusCode::UNAUTHORIZED, "Invalid credentials")
    }
}
