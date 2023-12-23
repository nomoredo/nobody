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
  /// ┌──────────── Title ─────────────┐
  /// ┌────────────────────────────────┐
  /// │ 1        │ 2        │ 3        │
  /// ├──────────┼──────────┼──────────┤
  /// │ 4        │ 5        │ 6        │
  /// └──────────┴──────────┴──────────┘
  /// borders are in gray and data is in white
  /// the first row is title and is in yellow
  /// second row is header and is in white
  /// the rest of the rows are in white
  /// automatically takes care of dynamic data checking if it is a map or a list or just a toString of the data
  /// automatically wraps each cell content to fit the width of the cell
  /// automatically calculates the width of each column based on the data

  static void table(Iterable<dynamic> data, {String title = "Title"}) {
    const int totalWidth = 80; // Total width of the table.

    // Convert all data to a list of maps for uniform processing.
    List<Map<String, dynamic>> rows =
        data.map<Map<String, dynamic>>((dynamic row) {
      if (row is Map) {
        return row
            .map((key, value) => MapEntry(key.toString(), value.toString()));
      } else if (row is Iterable) {
        // Convert Iterable to Map with string keys.
        return Map.fromIterables(
            Iterable<String>.generate(row.length, (i) => i.toString()),
            row.map((e) => e.toString()));
      } else {
        return {'Value': row.toString()};
      }
    }).toList();

    // Define the max key and value widths based on the data.
    int maxKeyWidth = 'Key'.length;
    int maxValueWidth = 'Value'.length;
    rows.forEach((Map<String, dynamic> row) {
      row.forEach((key, value) {
        maxKeyWidth = max(maxKeyWidth, key.length);
        maxValueWidth = max(maxValueWidth, value.length);
      });
    });

    // Adjust the key and value widths based on the total width.
    if (maxKeyWidth + maxValueWidth + 3 > totalWidth) {
      maxKeyWidth =
          (maxKeyWidth / (maxKeyWidth + maxValueWidth) * (totalWidth - 3))
              .floor();
      maxValueWidth = totalWidth - 3 - maxKeyWidth;
    }

    // Function to generate horizontal border lines.
    String horizontalLine(String left, String right, String fill) {
      return left + fill * (totalWidth - 2) + right;
    }

    // Function to print a single row of key-value.
    printRow(String key, String value) {
      key = key.padRight(maxKeyWidth);
      value = value.padRight(maxValueWidth);
      print('│ $key │ $value │');
    }

    // Print the table with transposed key-value pairs.
    print(horizontalLine('╭', '╮', '─')); // Top border
    print('│ ${title.padRight(totalWidth - 4)} │'); // Title
    print(horizontalLine('├', '┤', '─')); // Separator

    // Iterate through each row and print key-value pairs.
    for (var row in rows) {
      for (var entry in row.entries) {
        printRow(entry.key, entry.value);
      }
      // Separator between data entries.
      print(horizontalLine('├', '┤', '─'));
    }

    print(horizontalLine('╰', '╯', '─')); // Bottom border
  }
}
