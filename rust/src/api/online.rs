use crate::{show, yellow, gray_dim};

use self::simple::show;

pub use super::*;
pub use thirtyfour::prelude::*;
pub use tokio;
pub use tokio::time::{sleep, Duration};
pub use std::time::Instant;
pub use std::sync::Arc;
pub use std::sync::Mutex;
pub use std::thread;
pub use crate::error::Result;




pub async fn init_driver() -> WebDriver {
    //check if webdriver is running
    //if not, start it
    if !is_webdriver_running().await {
        start_webdriver().await;
    }

    let mut caps = DesiredCapabilities::edge();
    
    let wd = WebDriver::new("http://localhost:9515", caps)
        .await
        .expect("can't connect to webdriver");

    wd.set_script_timeout(Duration::from_secs(10))
        .await
        .expect("can't set script timeout");

    wd.set_page_load_timeout(Duration::from_secs(10))
        .await
        .expect("can't set page load timeout");

    wd.set_implicit_wait_timeout(Duration::from_secs(10))
        .await
        .expect("can't set implicit wait timeout");

    wd.set_window_name("nobody")
        .await
        .expect("can't set window name");






    wd
}

pub async fn is_webdriver_running() -> bool {
    let res = reqwest::get("http://localhost:9515/status").await;
    match res {
        Ok(res) => {
            if res.status().is_success() {
                return true;
            }
        }
        Err(_) => {}
    }
    false
}

pub async fn start_webdriver() {
    let driver_path = get_driver_path().await.expect("can't get driver path");
    show!(gray,"STARTING",yellow_bold,"WEBDRIVER",yellow_dim,format!("DRIVER {}", &driver_path));


    // Redirecting stdout and stderr to null
    let mut child = std::process::Command::new(driver_path)
        .arg("--port=9515")
        .arg("--disable-extensions")
        .arg("--disable-popup-blocking")
        .arg("--bwsi")
        .arg("--no-first-run")
        .arg("--no-default-browser-check")
        .arg("--disable-default-apps")
        .arg("--disable-translate")
        .arg("--disable-background-networking")
        .arg("--disable-background-timer-throttling")
        .stdout(std::process::Stdio::null())  // Redirect stdout to null
        .stderr(std::process::Stdio::null())  // Redirect stderr to null
        .spawn()
        .expect("can't start webdriver");

    std::thread::sleep(std::time::Duration::from_secs(1));

    let res = reqwest::get("http://localhost:9515/status").await;
    match res {
        Ok(res) => {
            if res.status().is_success() {
                return;
            }
        }
        Err(_) => {}
    }
    child.kill().expect("can't kill webdriver");
    panic!("can't start webdriver");
}

pub const JS_AUTO_CLOSE_BROWSER_IF_PROGRAM_CRASHES: &str = r#"
        window.addEventListener('error', function (e) {
            window.close();
        });
    "#;



pub async fn get_driver_path() -> Result<String> {
    let driver_dir = get_driver_dir()?;
    let driver_path = format!("{}/msedgedriver.exe", driver_dir);
    if !std::path::Path::new(&driver_path).exists() {
        download_driver(driver_dir).await?;
    }
    Ok(driver_path)
}

pub async fn download_driver(driver_dir: String) -> Result<bool> {
    let edge_version = get_edge_version()?;
    let url = format!("https://msedgedriver.azureedge.net/{}/edgedriver_win64.zip", edge_version);
    show!(gray_dim,"DOWNLOADING",yellow_bold,"DRIVER", yellow_dim,"VERSION",yellow_bold,format!("{}", &edge_version));
    let res = reqwest::get(&url).await?;
    let bytes = res.bytes().await?;
    let mut zip = zip::ZipArchive::new(std::io::Cursor::new(bytes))?;
    for i in 0..zip.len() {
        let mut file = zip.by_index(i)?;
        let file_name = file.name().to_string();
        let file_path = format!("{}/{}", driver_dir, file_name);
        if file_path.ends_with("/") {
            std::fs::create_dir_all(&file_path)?;
        } else {
            let mut new_file = std::fs::File::create(&file_path)?;
            std::io::copy(&mut file, &mut new_file)?;
        }
    }
    show!(gray,"DRIVER",yellow_bold,format!("{} {}", &edge_version, "DOWNLOADED"));
    Ok(true)
}


pub fn  get_driver_dir() -> Result<String> {
    //find the currently running edge version and find the corresponding driver
    let edge_version = get_edge_version()?;
    show!(gray_dim,"EDGE",yellow_bold,"VERSION",yellow_dim,format!("{}", &edge_version));
    let app_home_dir = get_app_home_dir()?;
    let driver_dir = format!("{}/drivers/{}", app_home_dir, edge_version);
    if !std::path::Path::new(&driver_dir).exists() {
        std::fs::create_dir_all(&driver_dir).expect("can't create driver dir");
    }
    Ok(driver_dir)
}

pub fn get_app_home_dir() -> Result<String> {
    let home_dir = dirs::home_dir().expect("can't get home dir");
    let nobody_dir = home_dir.join(".nobody");
    if !nobody_dir.exists() {
        std::fs::create_dir(&nobody_dir).expect("can't create nobody dir");
    }
    Ok(nobody_dir.to_str().unwrap().to_string())
}

pub fn get_edge_version() -> Result<String> {
    let output = std::process::Command::new("wmic")
        .arg("datafile")
        .arg("where")
        .arg("name='C:\\\\Program Files (x86)\\\\Microsoft\\\\Edge\\\\Application\\\\msedge.exe'")
        .arg("get")
        .arg("Version")
        .output()?;
    let output = String::from_utf8(output.stdout)?;
    let output = output.trim();
    let output = output.replace("Version", "");
    let output = output.trim();
    show!(gray,"DOWNLOADED",gray_dim,"EDGE",yellow_bold,"VERSION",yellow_dim,format!("{}", &output));
    Ok(output.to_string())
}
