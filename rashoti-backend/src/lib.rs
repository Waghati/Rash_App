pub mod config;
pub mod models;
pub mod handlers;
pub mod services;
pub mod middleware;
pub mod utils;

use sqlx::PgPool;
use std::sync::Arc;

#[derive(Clone)]
pub struct AppState {
    pub db: PgPool,
    pub config: Arc<config::Settings>,
}