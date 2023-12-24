use std::path;

use crate::{show, info};


pub fn my_custom_func(a: i32, b: i32) -> i32 {
    a + b
    
}


pub fn show(name: String) {
    show!(green, name);
}

pub fn get_files()-> Vec<String> {
    path::Path::new("./").read_dir().unwrap().map(|x| x.unwrap().path().display().to_string()).collect()
}