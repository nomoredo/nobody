@REM go to rust folder and run cargo build
cd rust
cargo check
cargo build --release
cd ..
@REM generate glue code
flutter_rust_bridge_codegen generate --config-file .\flutter_rust_bridge.yaml
@REM build dart app
dart pub run build_runner build --delete-conflicting-outputs
@REM pub get
dart pub get