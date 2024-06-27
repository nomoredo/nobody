pub use nobody::*;

lazy_static::lazy_static! {
    static ref RUNTIME: tokio::runtime::Runtime = tokio::runtime::Builder
        ::new_current_thread()
        .enable_all()
        .build()
        .unwrap();
}

fn main() {
    show_banner();

    let options = get_options();
    // let selection = show::menu(&options);
    let selection = async_menu("what do you want to do?", &options);
    if let Some(selection) = selection {
        RUNTIME.block_on(async move {
            let line = "─".repeat(65 - selection.get_name().len() + 2) + " ";

            showln!(yellow_bold, line, white, selection.get_name().to_lowercase());
            let now = std::time::Instant::now();
            let result = selection.run().await;
            let elapsed = now.elapsed();
            let elapsed = format!("{}.{:03} seconds", elapsed.as_secs(), elapsed.subsec_millis());
            let line = "─".repeat(65 - elapsed.len() + 2) + " ";
            showln!(yellow_bold, line, white, elapsed);
        })
    }
}
