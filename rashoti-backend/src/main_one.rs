use axum::{
    routing::get,
    Router,
    response::Json,
};

use serde_json::json;
use tracing::Value;
use std::net::SocketAddr;
use tracing_subscriber;


#[derive(Debug, Deserialize)]
struct MoodleCourse{
    id: u32,
    fullname: String,
    shortname: String,
    summary: String,
    visible: u8,
    startdate: u64,
    enddate: u64,
}

#[derive(Debug, serde::Serialize)]
struct CourseSummary {
    id: u32,
    name: String,
    code: String,
    summary: String,
    start: u64,
    end: u64,
    visible: bool,
}

#[tokio::main]
async fn main(){
    // Log Setup
    tracing_subscriber::fmt::init();

    // Build app with one route
    let app = Router::new()
        .route("/", get(root_handler))
        .route("/courses", get(get_courses)); 

    // Run on local host:3000
    let addr = SocketAddr::from(([127, 0, 0, 1], 3000));
    println!("Server running at http://{}", addr);
    //tracing::debug!("Listening on {}", addr);

    axum::serve(
        tokio::net::TcpListener::bind(addr).await.unwrap(), app)
    .await
    .unwrap();
}

async fn get_courses() -> Json<Value> {
    let base_url = env::var("MOODLE_BASE_URL").unwrap_or_default();
    let token = env::var("MOODLE_API_TOKEN").unwrap_or_default();

    let url = format!(
        "{}/webservice/rest/server.php?wstoken={}&moodlewsrestformat=json&wsfunction=core_course_get_courses",
        base_url, token
    );

    match reqwest::get(&url).await {
        Ok(response) => {
            if response.status().is_success() {
                let raw_courses = response.json::<Vec<MoodleCourse>>().await.unwrap_or_default();

                let clean: Vec<CourseSummary> = raw_courses
                    .into_iter()
                    .filter(|c| c.visible == 1) // only visible
                    .map(|c| CourseSummary {
                        id: c.id,
                        name: c.fullname,
                        code: c.shortname,
                        summary: c.summary,
                        start: c.startdate,
                        end: c.enddate,
                        visible: true,
                    })
                    .collect();

                Json(json!({ "courses": clean }))
            } else {
                Json(json!({ "error": "Failed to fetch courses", "status": response.status() }))
            }
        }
        Err(e) => Json(json!({ "error": format!("Request failed: {}", e) })),
    }
}

async fn root() -> Json<serde_json::Value> {
    Json(json!({"message": "Welcome to Rashoti Technologies!"}))
}