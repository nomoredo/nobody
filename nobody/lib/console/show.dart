import 'dart:math';

import 'package:coco/coco.dart';
import 'package:nobody/lib.dart';

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

  static Future elements(List<ElementHandle> elements) async {
    for (var e in elements) {
      await element(e);
    }
  }

  ///[e](gray) ─╮ [tagName](yellow)
  ///            ╰ [remote](white)
  ///            ╰ [local](gray)
  static Future element(ElementHandle e) async {
    var properties = await e.evaluate('''e => {
  return {
    className: e.className,
    title: e.title,
    id: e.id,
    // Add other properties you need
  };
}''');
    for (var p in properties.entries) {
      "".write(inGray);
      " ─╮ ".write(inGray);
      print(p.key);
      " ".write(inGray);
      " ╰ ${p.value}".write(inYellow);
      print("");
    }
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

  /// show the data as a table
  /// using box drawing characters like ─╮ ╰ ╭ ╯ │ ─ or sharp corners like ┌ ┐ └ ┘
  /// ╭──────────────────────────────────────────────────────────╮
  /// │                           Title                          │
  /// ├──────────────────────────────────────────────────────────┤
  /// │ id         │ application-ZFOC_TRIP_FORM-display-compon   │
  /// │            │ ent---object--Pernr-inner                   │
  /// ├────────────┼─────────────────────────────────────────────┤
  /// │ className  │ sapUiBody                                   │
  /// ╰──────────────────────────────────────────────────────────╯
  /// borders are in gray and data is in white
  /// the first row is title and is in yellow
  /// second row is header and is in white
  /// the rest of the rows are in white
  /// automatically takes care of dynamic data checking if it is a map or a list or just a toString of the data
  /// automatically wraps each cell content to fit the width of the cell
  /// automatically calculates the width of each column based on the data
  static void table(Iterable<dynamic> data, {String title = "Title"}) {
    const int totalWidth = 60; // Adjust this to the desired total width.
    const int keyWidth = 10; // Width allocated for keys.
    const int valueWidth = 50; // Width allocated for values.
    const int gapWidth = 2; // Minimum gap between columns.

    // Calculate actual column widths for each column.
    final int actualKeyWidth =
        min(keyWidth, data.map((e) => e.toString().length).reduce(max));
    final int actualValueWidth =
        min(valueWidth, data.map((e) => e.toString().length).reduce(max));
    final int actualGapWidth =
        min(gapWidth, totalWidth - actualKeyWidth - actualValueWidth);

    // Create the table header.
    final String header =
        '╭${'─' * actualKeyWidth}╮${'─' * actualGapWidth}╭${'─' * actualValueWidth}╮';

    // Create the table footer.
    final String footer =
        '╰${'─' * actualKeyWidth}╯${'─' * actualGapWidth}╰${'─' * actualValueWidth}╯';

    // Print the table header.
    print(header);

    // Print the title.
    print('│${title.center(totalWidth)}│');

    // Print the table header.
    print(header);

    // Print the table contents.
    for (final MapEntry<String, dynamic> entry in data) {
      final List<String> lines = entry.value.toString().split('\n');
      for (final String line in lines) {
        print(
            '│${entry.key.padRight(actualKeyWidth)}│${' ' * actualGapWidth}│${line.padRight(actualValueWidth)}│');
      }
    }

    // Print the table footer.
    print(footer);
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

        print('$prefix  $node$formattedKey : ${value.toString().inGray}}');

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
