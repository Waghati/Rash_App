use axum::{response::IntoResponse, extract::TypedHeader, headers::Authorization};
use crate::auth::jwt::validate_jwt;

pub async fn get_courses(TypedHeader(auth): TypedHeader<Authorization<String>>) -> impl IntoResponse {
    if let Some(_claims) = validate_jwt(auth.token()) {
        // Fetch Moodle courses or use dummy data
        let courses = vec![
            serde_json::json!({
                "id": 1,
                "name": "KCSE Mathematics",
                "code": "mathP1",
                "description": "KCSE Math Syllabus for Kenyan students"
            }),
        ];
        axum::Json(serde_json::json!({ "courses": courses }))
    } else {
        (axum::http::StatusCode::UNAUTHORIZED, "Invalid token").into_response()
    }
}
