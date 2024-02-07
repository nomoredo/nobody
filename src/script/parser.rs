pub use super::*;
use nom::{
    branch::alt,
    bytes::complete::{tag, take_until},
    character::complete::{alpha1, alphanumeric1, char, digit1, multispace0, multispace1},
    combinator::{eof, map, opt, recognize, rest},
    multi::{many0, separated_list0},
    sequence::{delimited, pair, preceded, terminated, tuple},
    IResult,
};
use std::collections::HashMap;


pub fn parse_value(input: &str) -> IResult<&str, Value> {
    alt((
        map(parse_string, Value::String),
        map(parse_number, Value::Number),
        map(parse_list, Value::List),
        map(parse_map, Value::Map),
        map(parse_null, |_| Value::Null),
    ))(input)
}

#[test]
fn test_parse_value() {
    assert_eq!(parse_value("null"), Ok(("", Value::Null)));
    assert_eq!(parse_value("\"hello\""), Ok(("", Value::String("hello".to_string()))));
    assert_eq!(parse_value("123"), Ok(("", Value::Number(123.0))));
    assert_eq!(parse_value("[1, 2, 3]"), Ok(("", Value::List(vec![Value::Number(1.0), Value::Number(2.0), Value::Number(3.0)]))));
    assert_eq!(parse_value("{\"a\": 1, \"b\": 2}"), Ok(("", Value::Map([("a".to_string(), Value::Number(1.0)), ("b".to_string(), Value::Number(2.0))].iter().cloned().collect()))));
}


pub fn parse_string(input: &str) -> IResult<&str, String> {
    let (input, s) = delimited(char('"'), take_until("\""), char('"'))(input)?;
    Ok((input, s.to_string()))
}

pub fn parse_number(input: &str) -> IResult<&str, f32> {
    let (input, s) = recognize(pair(opt(char('-')), digit1))(input)?;
    Ok((input, s.parse().unwrap()))
}

pub fn parse_list(input: &str) -> IResult<&str, Vec<Value>> {
  let (input,_)=char('[')(input)?;
    let (input,_) = multispace0(input)?;
    // manage nested lists and maps (do not use separated_list0 as it will not work for nested lists and maps)
    // instead, we will use many0 with a custom parser that handles the comma and the end of the list
    // also work with tailing comma and no comma at the end
    let (input, list) = many0(preceded(multispace0, terminated(parse_value, opt(preceded(multispace0, char(','))))))(input)?;
    let (input,_) = multispace0(input)?;
    let (input,_) = char(']')(input)?;
    Ok((input, list))


}

#[test]
fn test_parse_list() {
    assert_eq!(parse_list("[]"), Ok(("", vec![])));
    assert_eq!(parse_list("[1, 2, 3]"), Ok(("", vec![Value::Number(1.0), Value::Number(2.0), Value::Number(3.0)])));
    assert_eq!(parse_list("[\"a\", \"b\", { a : 1}]"), Ok(("", vec![Value::String("a".to_string()), Value::String("b".to_string()), Value::Map([("a".to_string(), Value::Number(1.0))].iter().cloned().collect())])));
}


pub fn parse_map(input: &str) -> IResult<&str, HashMap<String, Value>> {
    let (input,_) = char('{')(input)?;
    let (input,_) = multispace0(input)?;
    let (input, list) = many0(preceded(multispace0, terminated(parse_key_value, opt(preceded(multispace0, char(','))))))(input)?;
    let (input,_) = multispace0(input)?;
    let (input,_) = char('}')(input)?;
    Ok((input, list.into_iter().collect()))
}

pub fn parse_key_value(input: &str) -> IResult<&str, (String, Value)> {
    let (input, key) = alt((parse_string, parse_key))(input)?;
    let (input,_) = multispace0(input)?;
    let (input,_) = char(':')(input)?;
    let (input,_) = multispace0(input)?;
    let (input, value) = parse_value(input)?;
    Ok((input, (key, value)))
}

pub fn parse_null(input: &str) -> IResult<&str, ()> {
    let (input, _) = tag("null")(input)?;
    Ok((input, ()))
}

/// Meta
/// ```no
/// name: "hello"
/// age: 123
/// imports: ["a", "b", "c"]
/// ```
pub fn parse_meta(input: &str) -> IResult<&str, NoMeta> {
    let (input,_)   = multispace0(input)?;
    let (input,key_values) = many0(preceded(multispace0, parse_netada_pair))(input)?;
    Ok((input, NoMeta { data: key_values.into_iter().collect() }))

}

pub fn parse_netada_pair(input: &str) -> IResult<&str, (String, Value)> {
    let (input, key) = parse_key(input)?;
    let (input,_) = multispace0(input)?;
    let (input,_) = char(':')(input)?;
    let (input,_) = multispace0(input)?;
    let (input, value) = parse_value(input)?;
    Ok((input, (key, value)))
}

/// key
/// alpha followed by alphanumerics ends at the first non-alphanumeric character
pub fn parse_key(input: &str) -> IResult<&str, String> {
    let (input, _) = multispace0(input)?;
    let (input, key) = recognize(pair(alpha1, many0(alt((alphanumeric1, tag("_"))))))(input)?;
    Ok((input, key.to_string()))
}




#[test]
fn test_parse_meta() {
  let test = r#"
        name: "hello"
        age: 123
        imports: [ {name: "a"}, {name: "b"}, {name: "c"} ]
        "#;

    match parse_meta(test) {
        Ok((_, meta)) => {
            assert_eq!(meta.data.get("name"), Some(&Value::String("hello".to_string())));
            assert_eq!(meta.data.get("age"), Some(&Value::Number(123.0)));
            assert_eq!(meta.data.get("imports"), Some(&Value::List(vec![Value::Map([("name".to_string(), Value::String("a".to_string()))].iter().cloned().collect()), Value::Map([("name".to_string(), Value::String("b".to_string()))].iter().cloned().collect()), Value::Map([("name".to_string(), Value::String("c".to_string()))].iter().cloned().collect())])));
     },
        Err(e) => {
            println!("error: {:?}", e);
            assert!(false);
        }
    }
}



 pub fn parse_noscript(input: &str) -> IResult<&str, NoScript> {
    let (input,_) = ignorables(input)?;
    let (input, meta) = parse_meta(input)?;
    let (input,_) = ignorables(input)?;
    let (input, code) = rest(input)?;
    //remove unnecessary newlines and spaces from the code
    let mut code = code.to_string();
    code = remove_unnecessary_spaces(&code);    
    code = remove_unnecessary_newlines(&code);
    Ok((input, NoScript { path: "".to_string(), meta, code: code.to_string() }))
 }

 fn remove_unnecessary_spaces(input: &str) -> String {
    let mut code = input.to_string();
    while code.contains("\n\n") {
        code = code.replace("\n\n", "\n");
      }
  
      while code.contains("  ") {
         code = code.replace("  ", " ");
       }
    code
 }

 fn remove_unnecessary_newlines(input: &str) -> String {
    let mut code = input.to_string().trim().to_string();
    while code.contains("\n\n") {
        code = code.replace("\n\n", "\n");
      }
    code
 }

   pub fn comments(input: &str) -> IResult<&str, &str> {
    let (input,_) = multispace0(input)?;
    let (input,_) = tag("//")(input)?;
    let (input,_) = multispace0(input)?;
    let (input,_) = take_until("\n")(input)?;
    Ok((input, ""))
}

pub fn ignorables(input: &str) -> IResult<&str, &str> {
    let (input,_) = many0(comments)(input)?;
    let (input,_) = multispace0(input)?;
    Ok((input, ""))
}



    #[test]
    fn test_parse_noscript() {
        let test = r#"
            /// sample script
            author: "amohandas"
            description: "this is a test"
            version: "1.0"
            imports:[  {name: "sap", version: "1.0"}, {name: "minimo", path: "./minimo"}  ]
            
        
            /// start of script
            Nobody()
              .online()
              .login(Sap.User('amohandas'))
              .goto(SapTransaction("ZHR076A"))
              .set(Sap.Input("Personnel Number"), "9711068")
              .set(Input.WithId("M0:46:::2:34"), "01.01.2023")
              .set(Input.WithId("M0:46:::2:59"), "01.01.2024")
              .click(Sap.Execute)
              .download(Sap.DownloadableTable, AbstractPath.Relative("attendance.xlsx"))
              .wait(Waitable.Seconds(50)) // this was for testing
              .close();
                "#;

        let codetomatch = r#"Nobody()
            .online()
            .login(Sap.User('amohandas'))
            .goto(SapTransaction("ZHR076A"))
            .set(Sap.Input("Personnel Number"), "9711068")
            .set(Input.WithId("M0:46:::2:34"), "01.01.2023")
            .set(Input.WithId("M0:46:::2:59"), "01.01.2024")
            .click(Sap.Execute)
            .download(Sap.DownloadableTable, AbstractPath.Relative("attendance.xlsx"))
            .wait(Waitable.Seconds(50)) // this was for testing
            .close();"#;
        let codetomatch = remove_unnecessary_spaces(codetomatch);
        let codetomatch = remove_unnecessary_newlines(&codetomatch);

        match parse_noscript(test) {
            Ok((_, noscript)) => {
                assert_eq!(noscript.meta.data.get("author"), Some(&Value::String("amohandas".to_string())));
                assert_eq!(noscript.meta.data.get("description"), Some(&Value::String("this is a test".to_string())));
                assert_eq!(noscript.meta.data.get("version"), Some(&Value::String("1.0".to_string())));
                assert_eq!(noscript.meta.data.get("imports"), Some(&Value::List(vec![
                    Value::Map([("name".to_string(), Value::String("sap".to_string())), ("version".to_string(), Value::String("1.0".to_string()))].iter().cloned().collect()),
                    Value::Map([("name".to_string(), Value::String("minimo".to_string())), ("path".to_string(), Value::String("./minimo".to_string()))].iter().cloned().collect())
                ])));
                assert_eq!(noscript.code, codetomatch.to_string());
            },
            Err(e) => {
                println!("error: {:?}", e);
                assert!(false);
            }
        }

    }
