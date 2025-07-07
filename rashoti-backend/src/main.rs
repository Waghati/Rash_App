use axum::{
    middleware,
    routing::{get, post},
    Router,
};
use rashoti_backend::{
    config::Settings,
    handlers::{auth, health},
    middleware::auth::auth_middleware,
    AppState,
};
use sqlx::postgres::PgPoolOptions;
use std::{net::SocketAddr, sync::Arc};
use tracing_subscriber;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Initialize tracing
    tracing_subscriber::fmt::init();

    // Load configuration
    let config = Settings::new()?;
    let config = Arc::new(config);

    // Connect to database
    let db = PgPoolOptions::new()
        .max_connections(50)
        .connect(&config.database_url)
        .await?;

    // Run migrations
    sqlx::migrate!("./migrations").run(&db).await?;

    // Create application state
    let state = AppState {
        db,
        config: config.clone(),
    };

    // Create protected routes
    let protected_routes = Router::new()
        .route("/api/auth/me", get(auth::me))
        .route_layer(middleware::from_fn_with_state(state.clone(), auth_middleware));

    // Build application routes
    let app = Router::new()
        // Public routes (no auth required)
        .route("/api/health", get(health::health_check))
        .route("/api/auth/register", post(auth::register))
        .route("/api/auth/login", post(auth::login))
        // Merge protected routes
        .merge(protected_routes)
        .with_state(state);

    // Start server
    let addr = SocketAddr::from(([127, 0, 0, 1], config.port));
    tracing::info!("Server starting on {}", addr);

    let listener = tokio::net::TcpListener::bind(addr).await?;
    axum::serve(listener, app).await?;

    Ok(())
}