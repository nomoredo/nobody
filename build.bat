@REM go to rust folder and run cargo build
cd rust
cargo build --release
cd ..
@REM generate glue code
flutter_rust_bridge_codegen generate --config-file .\flutter_rust_bridge.yaml
@REM build dart app
dart pub get
