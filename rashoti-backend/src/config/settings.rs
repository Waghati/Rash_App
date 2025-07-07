use serde::Deserialize;

#[derive(Debug, Deserialize, Clone)]
pub struct Settings {
    pub database_url: String,
    pub jwt_secret: String,
    pub jwt_expiration: u64,
    pub moodle_base_url: String,
    pub moodle_api_token: String,
    pub host: String,
    pub port: u16,
}

impl Settings {
    pub fn new() -> Result<Self, Box<dyn std::error::Error>> {
        dotenvy::dotenv().ok();
        
        let settings = Settings {
            database_url: std::env::var("DATABASE_URL")?,
            jwt_secret: std::env::var("JWT_SECRET")?,
            jwt_expiration: std::env::var("JWT_EXPIRATION")?.parse()?,
            moodle_base_url: std::env::var("MOODLE_BASE_URL")?,
            moodle_api_token: std::env::var("MOODLE_API_TOKEN")?,
            host: std::env::var("HOST").unwrap_or_else(|_| "0.0.0.0".to_string()),
            port: std::env::var("PORT")?.parse()?,
        };
        
        Ok(settings)
    }
}