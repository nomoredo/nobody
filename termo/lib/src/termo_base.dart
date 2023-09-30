import 'dart:io';

import 'package:coco/coco.dart';

import 'show.dart';

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
