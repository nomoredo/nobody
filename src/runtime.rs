use deno_core::error::AnyError;
use deno_core::{extension, op2, Extension};
use headless_chrome::{Browser, LaunchOptions, Tab};
use lazy_static::lazy_static;
use deno_core::serde::Deserialize;
use std::sync::{Arc, Mutex};
use std::fs::File;
use std::io::Write;
use tokio::sync::RwLock;

lazy_static! {
    static ref BROWSER: Arc<RwLock<Option<BrowserWrapper>>> = Arc::new(RwLock::new(None));
}

#[derive(Clone)]
struct BrowserWrapper {
    browser: Browser,
}

impl BrowserWrapper {
    async fn new() -> Result<Self, AnyError> {
        let mut options = LaunchOptions::default();
        options.headless = false;
        let browser = Browser::new(options)?;
        Ok(BrowserWrapper { browser })
    }

    async fn get_tab(&self) -> Result<Arc<Tab>, AnyError> {
        let tab = self.browser.new_tab()?;
        Ok(tab)
    }
}

#[op2(async)]
async fn op_init_browser() -> Result<(), AnyError> {
    let wrapper = BrowserWrapper::new().await?;
    let mut browser_lock = BROWSER.write().await;
    *browser_lock = Some(wrapper);
    Ok(())
}

#[op2(async)]
#[string]
async fn op_navigate_to(#[string] url: String) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    tab.navigate_to(&url)?;
    tab.wait_until_navigated()?;
    Ok(())
}

#[op2(async)]
#[string]
async fn op_take_screenshot(#[string] path: String) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    let png_data = tab.capture_screenshot(
        headless_chrome::protocol::cdp::Page::CaptureScreenshotFormatOption::Png,
        Some(75),
        None,
        true,
    )?;
    let mut file = File::create(path)?;
    file.write_all(&png_data)?;
    Ok(())
}

#[op2(async)]
#[string]
async fn op_click(#[string] selector: String) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    tab.wait_for_element(&selector)?.click()?;
    Ok(())
}

#[op2(async)]
#[string]
async fn op_get_text(#[string] selector: String) -> Result<String, AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    let element = tab.wait_for_element(&selector)?;
    let text = element.get_inner_text()?;
    Ok(text)
}

#[op2(async)]
#[string]
async fn op_type_text(#[string] selector: String, #[string] text: String) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    let element = tab.wait_for_element(&selector)?;
    element.type_into(text.as_str())?;
    Ok(())
}

#[op2(async)]
async fn op_set_timeout(delay: f64) -> Result<(), AnyError> {
    tokio::time::sleep(std::time::Duration::from_millis(delay as u64)).await;
    Ok(())
}

#[op2(async)]
#[string]
async fn op_evaluate(#[string] script: String) -> Result<String, AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    let result = tab.evaluate(script.as_str(), false)?.value;
    if let Some(v) = result {
        Ok(v.to_string())
    } else {
        Ok("null".to_string())
    }
}

#[op2(async)]
#[string]
async fn op_fill_form(
    #[string] selector: String,
    #[string] values: String
) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    let element = tab.wait_for_element(&selector)?;
    let value_map: std::collections::HashMap<String, String> = serde_json::from_str(&values)?;
    for (field, value) in value_map {
        element.find_element(&field)?.type_into(value.as_str())?;
    }
    Ok(())
}

#[op2(async)]
#[string]
async fn op_wait_for_element(#[string] selector: String) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    tab.wait_for_element(&selector)?;
    Ok(())
}

#[op2(async)]
#[string]
async fn op_select_option(
    #[string] selector: String,
    #[string] value: String
) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    let element = tab.wait_for_element(&selector)?;
    // element.select(value)?;
    Ok(())
}

#[op2(async)]
#[bigint]
async fn op_scroll(#[bigint] x: i64, #[bigint] y: i64) -> Result<(), AnyError> {
    let browser_lock = BROWSER.read().await;
    let browser = browser_lock.as_ref().ok_or_else(|| AnyError::msg("Browser not initialized"))?;
    let tab = browser.get_tab().await?;
    tab.evaluate(format!("window.scrollTo({}, {});", x, y).as_str(), false)?;
    Ok(())
}

extension!(
    runjs,
    ops = [
        op_init_browser,
        op_navigate_to,
        op_take_screenshot,
        op_click,
        op_get_text,
        op_type_text,
        op_set_timeout,
        op_evaluate,
        op_fill_form,
        op_wait_for_element,
        op_select_option,
        op_scroll,
    ]
);
pub static RUNTIME_SNAPSHOT: &[u8] = include_bytes!(concat!(env!("OUT_DIR"), "/SNAP.bin"));
