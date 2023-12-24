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
  /// ┌─── HEAD
  /// │ 0
  /// │ └─── 0
  /// │      └─── 0 key : value
  /// │      └─── 1 key : value
  /// │      └─── 2 key : value
  /// │      └─── 3 key : value
  /// │      │              └───┐
  /// │      │              │ 0 list item 0
  /// │      │              │ 1 list item 1
  /// │      │              │ 2 list item 2
  /// │      │              │ 3 list item 3
  /// │      │              │ 4 list item 4
  /// │      │              │ 5 list item 5
  /// │      │              └──────────────
  /// │      └─── 4 key : value
  /// │      └─── 5 key : value
  /// │      └─── 6 key : value
  /// │                      └───┐
  ///

  static void tree(dynamic data, {String prefix = '', String? title}) {
    if (title != null) {
      print('${inGray(prefix)}${inMagenta(title)}');
    }
    if (data is Map) {
      final keys = data.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        final key = keys[i];
        final isLast = i == keys.length - 1;
        final node = isLast ? '└── ' : '├── ';
        final formattedKey = inCyan(key);
        final value = data[key];

        print('$prefix  $node$formattedKey : ${value.toString().inGray}');

        tree(value,
            prefix: '$prefix  ${isLast ? '    ' : '│   '}', title: null);
      }
    } else if (data is List) {
      var i = 0;
      for (var item in data) {
        if (item is Map) {
          tree(item, prefix: prefix, title: "item $i");
        } else {
          final isLast = (data.indexOf(item) == data.length - 1);
          final node = isLast ? '└── ' : '├── ';
          final formattedItem = inCyan(item.toString());

          print('$prefix  $node$formattedItem');
        }
        i++;
      }
    }
  }
}
