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

  /// divider
  /// ————————————————————————————————————————————————————————————
  static void divider() {
    "————————————————————————————————————————————————————————————"
        .write(inGray);
    print("");
  }

  static void request(String s, String string) {
    "REQUEST".write(inGray);
    " $s".write(inYellow);
    " $string".write(inWhite);
    print("");
  }

  static void banner(String banner, String footer) {
    print(banner);
    print(footer);
    divider();
  }

  ///[s](gray) [t](white) [u](gray) [v](white)
  static void credits(String s, String t, String u, String v) {
    s.write(inGray);
    " $t".write(inWhite);
    " $u".write(inGray);
    " $v".write(inWhite);
    print("");
    divider();
  }

  /// show the data as tree
  /// using box drawing characters like ─╮ ╰ ╭ ╯ │ ─ or sharp corners like ┌ ┐ └ ┘
  /// TITLE ─
  /// └ key (value is a map)
  ///   ├─ map child 0 : 00000000
  ///   ├─ map child 1 : 00000000
  ///   ├─ map child 2 : 00000000
  ///   ├─ map child 3 : 00000000
  ///   ├─ key (value is a list)
  ///   │  ├─ value 0
  ///   │  └─ value 1
  ///   └─ map child 4 : 00000000
  ///key is in yellow and value is in white. lines are in gray ┌ ┐ └ ┘
  static void tree(dynamic data, {String prefix = '', String? title}) {
    if (title != null) {
      title.write(inGray);
      print("");
    }
    switch (data.runtimeType) {
      case Map:
        data.write((key, value) {
          prefix.write(inGray);
          " $key".write(inYellow);
          " : ".write(inGray);
          if (value is Map) {
            print("");
            tree(value, prefix: prefix + "└─ ");
          } else if (value is List) {
            print("");
            tree(value, prefix: prefix + "└─ ");
          } else {
            "$value".write(inWhite);
            print("");
          }
        });
        break;
      case List:
        for (var i = 0; i < data.length; i++) {
          prefix.write(inGray);
          " $i".write(inYellow);
          " : ".write(inGray);
          if (data[i] is Map) {
            print("");
            tree(data[i], prefix: prefix + "└─ ");
          } else if (data[i] is List) {
            print("");
            tree(data[i], prefix: prefix + "└─ ");
          } else {
            "$data[i]".write(inWhite);
            print("");
          }
        }
        break;
      default:
        data.write(inWhite);
        print("");
    }
  }
}
