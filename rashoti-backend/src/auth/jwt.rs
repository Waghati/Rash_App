use jsonwebtoken::{encode, decode, Header, Validation, EncodingKey, DecodingKey};
use serde::{Serialize, Deserialize};
use std::time::{SystemTime, UNIX_EPOCH};

#[derive(Serialize, Deserialize)]
pub struct Claims {
    pub sub: String,
    pub exp: usize,
}

pub fn create_jwt(username: &str) -> String {
    let expiration = SystemTime::now().duration_since(UNIX_EPOCH).unwrap().as_secs() + 3600;
    let claims = Claims {
        sub: username.to_owned(),
        exp: expiration as usize,
    };
    encode(&Header::default(), &claims, &EncodingKey::from_secret(b"secret")).unwrap()
}

pub fn validate_jwt(token: &str) -> Option<Claims> {
    decode::<Claims>(
        token,
        &DecodingKey::from_secret(b"secret"),
        &Validation::default(),
    ).map(|data| data.claims).ok()
}
