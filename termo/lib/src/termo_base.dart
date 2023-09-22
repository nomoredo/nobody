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
