use std::fs;
use std::collections::HashSet;
use std::path::{ Path, PathBuf };
use deno_core::{
    ModuleLoader,
    ModuleSpecifier,
    ResolutionKind,
    ModuleSource,
    ModuleType,
    ModuleSourceCode,
};
use deno_core::error::AnyError;
use deno_ast::{ parse_module, EmitOptions, MediaType, ParseParams };
use minimo::{gray_dim, showln};
use std::sync::{ Arc, Mutex };
use reqwest::Client;
use serde_json::Value;
use regex::Regex;
use once_cell::sync::Lazy;
use deno_core::extension;
use std::rc::Rc;
use std::cell::RefCell;

// static NPM_PACKAGE_REGEX: Lazy<Regex> = Lazy::new(||
//     Regex::new(r#"(?m)^\s*import\s+.*?from\s+['"]([^./][^'"/][^'"]+)['"]"#).unwrap()
// );

pub struct TsModuleLoader {
    npm_cache: Arc<Mutex<HashSet<String>>>,
    client: Rc<RefCell<Client>>,
}

impl TsModuleLoader {
    pub fn new() -> Self {
        Self {
            npm_cache: Arc::new(Mutex::new(HashSet::new())),
            client: Rc::new(RefCell::new(Client::new())),
        }
    }

    pub fn contains_npm_package(&self, package_name: &str) -> bool {
        self.npm_cache.lock().unwrap().contains(package_name)
    }

    pub fn insert_npm_package(&self, package_name: String) {
        self.npm_cache.lock().unwrap().insert(package_name);
    }

    // async fn fetch_npm_package(&self, package_name: &str) -> Result<String, AnyError> {
    //     if self.contains_npm_package(package_name) {
    //         return Ok(String::new()); // Package already fetched
    //     }

    //     let url = format!("https://registry.npmjs.org/{}/latest", package_name);
    //     let response = self.client
    //         .borrow()
    //         .get(&url)
    //         .send().await?
    //         .json::<Value>().await?;
    //     showln!(green_bold, "fetched npm package: ", gray_dim, package_name);
    //     println!("{:#?}", response);

    //     let tarball = response["dist"]["tarball"].as_str().ok_or_else(|| AnyError::msg("Invalid tarball"))?;
    //     showln!(orange_bold, "downloading tarball: ", gray_dim, tarball);
    //     let package = self.client
    //         .borrow()
    //         .get(tarball)
    //         .send().await?
    //         .text().await?;

    //     self.insert_npm_package(package_name.to_string());
    //     Ok(package)

    // }

    // fn extract_npm_packages(&self, code: &str) -> Vec<String> {
    //     NPM_PACKAGE_REGEX.captures_iter(code)
    //         .filter_map(|cap| cap.get(1).map(|m| m.as_str().to_string()))
    //         .collect()
    // }
}

impl ModuleLoader for TsModuleLoader {
    fn resolve(
        &self,
        specifier: &str,
        referrer: &str,
        _kind: ResolutionKind
    ) -> Result<ModuleSpecifier, AnyError> {
        if specifier.starts_with("http://") || specifier.starts_with("https://") {
            return Ok(ModuleSpecifier::parse(specifier)?);
        }

        // if specifier.starts_with("npm:") {
        //     let package_name = specifier.trim_start_matches("npm:");
        //     return Ok(ModuleSpecifier::parse(&format!("npm://{}", package_name))?);
        // }

        if specifier.starts_with("file://") {
            return Ok(ModuleSpecifier::parse(specifier)?);
        }

        // Handle relative and absolute paths
        let referrer = ModuleSpecifier::parse(referrer)?;
        if specifier.starts_with('/') {
            // Absolute path
            return Ok(
                ModuleSpecifier::from_file_path(Path::new(specifier)).map_err(|_|
                    AnyError::msg("Invalid file path")
                )?
            );
        } else {
            // Relative path
            let referrer_path = if referrer.scheme() == "file" {
                referrer.to_file_path().map_err(|_| AnyError::msg("Invalid referrer file path"))?
            } else {
                PathBuf::from(referrer.path())
            };

            let resolved_path = if referrer_path.is_file() {
                referrer_path.parent().unwrap().join(specifier)
            } else {
                referrer_path.join(specifier)
            };

            return Ok(
                ModuleSpecifier::from_file_path(resolved_path.canonicalize()?).map_err(|_|
                    AnyError::msg("Invalid file path")
                )?
            );
        }
    }

    fn load(
        &self,
        module_specifier: &ModuleSpecifier,
        _maybe_referrer: Option<&ModuleSpecifier>,
        _is_dyn_import: bool,
        _requested_module_type: deno_core::RequestedModuleType
    ) -> deno_core::ModuleLoadResponse {
        let module_specifier = module_specifier.clone();
        let loader = self.clone();

        let module_load = async move {
            let code: String = match module_specifier.scheme() {
                "http" | "https" => {
                    showln!(yellow_bold, "loading remote module: ", gray_dim, module_specifier.as_str());
                    let content =loader.client
                        .borrow()
                        .get(module_specifier.as_str())
                        .send().await?
                        .text().await?;
                   showln!(gray_dim, content);
                    content
                }
                "file" => {
                 
                    if let Ok(path) = module_specifier.to_file_path() {
                        showln!(cyan_bold, "loading local module: ", gray_dim, path.display());
                        if path.is_file() {
                            fs
                                ::read_to_string(path)
                                .map_err(|_| AnyError::msg("Failed to read file"))?
                        } else {
                            //replace .js with .ts and try again
                            let path = path.with_extension("ts");
                            fs
                                ::read_to_string(path)
                                .map_err(|_| AnyError::msg("Failed to read file"))?
                        }
                    } else {
                        return Err(AnyError::msg("Invalid file path"));
                    }
                }
                // "npm" => {
               
                //     let package_name = module_specifier.path().trim_start_matches('/');
                //     showln!(orange_bold, "loading npm package: ", gray_dim, package_name);
                //     loader.fetch_npm_package(package_name).await?
                // }
                _ => {
                    return Err(AnyError::msg("Unsupported module specifier scheme"));
                }
            };

            // let npm_packages = loader.extract_npm_packages(&code);
            // for package in npm_packages {
            //     loader.fetch_npm_package(&package).await?;
            // }

            let media_type = MediaType::from_specifier(&module_specifier);
            let code = if matches!(media_type, MediaType::TypeScript | MediaType::Tsx) {
                let parsed = parse_module(ParseParams {
                    specifier: module_specifier.clone(),
                    text: code.into(),
                    media_type,
                    capture_tokens: false,
                    scope_analysis: false,
                    maybe_syntax: None,
                })?;
                let transpiled = parsed.transpile(&Default::default(), &EmitOptions::default())?;
                transpiled.into_source().into_string().unwrap().text
            } else {
                code
            };

            Ok(
                ModuleSource::new(
                    ModuleType::JavaScript,
                    ModuleSourceCode::String(code.into()),
                    &module_specifier,
                    None
                )
            )
        };

        deno_core::ModuleLoadResponse::Async(Box::pin(module_load))
    }
}

impl Clone for TsModuleLoader {
    fn clone(&self) -> Self {
        Self {
            npm_cache: Arc::clone(&self.npm_cache),
            client: Rc::clone(&self.client),
        }
    }
}

