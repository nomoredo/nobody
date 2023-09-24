import 'dart:io';

import 'package:coco/coco.dart';

class Show {
  //INFO
  //gray,cyan,yellow,white,red,green,blue,magenta
  static void info(String message, [String? a, String? b, String? c]) {
    message.write(inGray);
    if (a != null) {
      " $a".write(inCyan);
    }
    if (b != null) {
      " $b".write(inYellow);
    }
    if (c != null) {
      " $c".write(inWhite);
    }
    print("");
  }

  //ERROR
  //gray,red,yellow,white,gray
  static void error(String message, [String? a, String? b, String? c]) {
    message.write(inGray);
    if (a != null) {
      " $a".write(inRed);
    }
    if (b != null) {
      " $b".write(inYellow);
    }
    if (c != null) {
      " $c".write(inWhite);
    }
    print("");
  }

  //SUCCESS
  //gray,green,yellow,white,gray
  static void success(String message, [String? a, String? b, String? c]) {
    message.write(inGray);
    if (a != null) {
      " $a".write(inGreen);
    }
    if (b != null) {
      " $b".write(inYellow);
    }
    if (c != null) {
      " $c".write(inWhite);
    }
    print("");
  }

  //WARNING
  //gray,orange,yellow,white,gray
  static void warning(String message, [String? a, String? b, String? c]) {
    message.write(inGray);
    if (a != null) {
      " $a".write(inYellow);
    }
    if (b != null) {
      " $b".write(inMagenta);
    }
    if (c != null) {
      " $c".write(inWhite);
    }
    print("");
  }

  //action
  //gray,yellow,cyan,white,gray
  static void action(String message,
      [String? a, String? b, String? c, String? d]) {
    message.write(inGray);
    if (a != null) {
      " $a".write(inYellow);
    }
    if (b != null) {
      " $b".write(inCyan);
    }
    if (c != null) {
      " $c".write(inWhite);
    }
    if (d != null) {
      " $d".write(inGray);
    }
    print("");
  }

  //input
  //gray,magenta,white,gray,cyan
  static void input(String message,
      [String? a, String? b, String? c, String? d]) {
    message.write(inGray);
    if (a != null) {
      " $a".write(inMagenta);
    }
    if (b != null) {
      " $b".write(inWhite);
    }
    if (c != null) {
      " $c".write(inGray);
    }
    if (d != null) {
      " $d".write(inCyan);
    }
    print("");
  }

  //please enter
  //semantic colors for
  //[please enter] [sap] [password] [for] [amohandas]
  static void pleaseEnter(String message,
      [String? a, String? b, String? c, String? d]) {
    message.write(inGray);
    if (a != null) {
      " $a".write(inCyan);
    }
    if (b != null) {
      " $b".write(inYellow);
    }
    if (c != null) {
      " $c".write(inWhite);
    }
    if (d != null) {
      " $d".write(inCyan);
    }
    print("");
  }

  static void progress(String s, received, total) {
    s.write(inGray);
    " $received".write(inYellow);
    " $total".write(inWhite);
    print("");
  }

  static void anything(dynamic a, [int indent = 0]) {
    //use dart 3.0 pattern matching to
    // print anything in a colorized and indented way (tree like)
    if (a is Map) {
      a.forEach((key, value) {
        if (value is Map) {
          print("${"\x1B[32;5;240m${" " * indent}" + key}\x1B[0m");

          anything(value, indent + 1);
        } else if (value is List) {
          print("${"\x1B[35;5;240m${" " * indent * 2}" + key}\x1B[0m");
          anything(value, indent + 1);
        } else {
          print(
              '${"\x1B[33;5;240m${" " * indent * 2}" + key}\x1B[0m:${"\x1B[31;5;240m $value\x1B[0m"}');
        }
      });
    } else if (a is List) {
      for (var element in a) {
        if (element is Map) {
          anything(element, indent + 1);
        } else if (element is List) {
          anything(element, indent + 1);
        } else {
          "".write(inGray);
          " ".write(inGray);
          element.write(inWhite);
          print("");
        }
      }
    }
  }

  static void title(String s) {
    divider();
    '${" " * ((60 - s.length) ~/ 2)}$s'.write(inYellow);
    print("");
    divider();
  }

  static void divider() {
    "————————————————————————————————————————————————————————————"
        .write(inGray);
    print("");
  }
}

class Ask {
  static Future<String> password(String scope, String key) async {
    Show.pleaseEnter("PLEASE ENTER", scope, "PASSWORD", "FOR", key);
    var password = await prompt('PASSWORD', hideInput: true);
    return password;
  }

  static Future<String> input(String scope, String key) async {
    Show.pleaseEnter("INPUT", scope, key);
    var input = await prompt('INPUT');
    return input;
  }

  static Future<String> prompt(String message, {bool hideInput = false}) async {
    //YELLOW BACKGROUND BLACK TEXT
    message.write(inYellow);
    " ".write(inBlack);
    // for each char being typed if hideInput is true then print a * otherwise print the char (handle backspace)
    var input = "";
    while (true) {
      var char = stdin.readByteSync();
      if (char == 127) {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
          stdout.write('\b \b');
        }
      } else if (char == 10 || char == 13) {
        break;
      } else {
        input += String.fromCharCode(char);
        if (hideInput) {
          stdout.write('*');
        } else {
          stdout.write(String.fromCharCode(char));
        }
      }
    }
    print("");
    return input;
  }
}
