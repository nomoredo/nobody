pub use super::*;




#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum Error {
    Simple(String),
    Other(String),
}

impl std::error::Error for Error {}

impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            Error::Simple(msg) => write!(f, "{}", msg),
            Error::Other(msg) => write!(f, "{}", msg),
        }
    }
}


impl From<error::Error> for Error {
    fn from(err: error::Error) -> Self {
        Error::Other(format!("{}", err))
    }
}

impl From<std::io::Error> for Error {
    fn from(err: std::io::Error) -> Self {
        Error::Other(format!("{}", err))
    }
}

impl From<reqwest::Error> for Error {
    fn from(err: reqwest::Error) -> Self {
        Error::Other(format!("{}", err))
    }
}

impl From<thirtyfour::error::WebDriverError> for Error {
    fn from(err: thirtyfour::error::WebDriverError) -> Self {
        Error::Other(format!("{}", err))
    }
}

impl From<tokio::task::JoinError> for Error {
    fn from(err: tokio::task::JoinError) -> Self {
        Error::Other(format!("{}", err))
    }
}


impl From<std::io::ErrorKind> for Error {
    fn from(err: std::io::ErrorKind) -> Self {
        Error::Other(format!("{}", err))
    }
}

impl From<serde_json::Error> for Error {
    fn from(err: serde_json::Error) -> Self {
        Error::Other(format!("{}", err))
    }
}


pub type Result<T> = std::result::Result<T, Error>;
