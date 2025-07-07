// use crate::services::auth_service::Claims;
use crate::utils::errors::AppError;
use axum::{
    extract::{Request, State},
    http::header::AUTHORIZATION,
    middleware::Next,
    response::Response,
};
use crate::AppState;

pub async fn auth_middleware(
    State(state): State<AppState>,
    mut request: Request,
    next: Next,
) -> Result<Response, AppError> {
    let auth_header = request
        .headers()
        .get(AUTHORIZATION)
        .and_then(|header| header.to_str().ok())
        .ok_or_else(|| AppError::AuthenticationError("Missing authorization header".to_string()))?;

    if !auth_header.starts_with("Bearer ") {
        return Err(AppError::AuthenticationError(
            "Invalid authorization header format".to_string(),
        ));
    }

    let token = &auth_header[7..];
    let auth_service = crate::services::auth_service::AuthService::new(
        state.db.clone(),
        state.config.jwt_secret.clone(),
        state.config.jwt_expiration,
    );

    let claims = auth_service.validate_jwt(token)?;
    
    // Insert claims into request extensions
    request.extensions_mut().insert(claims);
    
    Ok(next.run(request).await)
}