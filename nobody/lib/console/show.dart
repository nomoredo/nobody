import 'package:coco/coco.dart';
import 'package:puppeteer/protocol/dom.dart';

import '../references.dart';

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
  /// box drawing characters like ─╮ ╰ ╭ ╯ │ ─ or sharp corners like ┌ ┐ └ ┘
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

  /// show the data as tree structure
  /// ┌─ TITLE ─
  /// │  ├─ key (value is a map)
  /// │  │  ├─ map child 0 : 00000000
  /// │  │  ├─ map child 1 : 00000000
  /// │  │  ├─ map child 2 : 00000000
  /// │  │  ├─ map child 3 : 00000000
  /// │  │  └─ key (value is a list)
  /// │  │     │  ├─ value 0
  /// │  │     │  └─ value 1
  /// │  └─ map child 4 : 00000000
  /// └─────────────────────────────────

  static void tree(dynamic data, {String prefix = '', String? title}) {
    if (title != null) {
      print('$prefix┌─ $title ─');
      prefix += "│  "; // Add spacing for nested items under the title
    }
    if (data is Map) {
      var keys = data.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        var key = keys[i];
        var isLast = i == keys.length - 1;
        var value = data[key];
        print(prefix + (isLast ? "└─ " : "├─ ") + inGray(key.toString()));
        tree(value, prefix: isLast ? prefix + "  " : prefix + "│  ");
      }
    } else if (data is Iterable) {
      var items = data.toList();
      for (var i = 0; i < items.length; i++) {
        var isLast = i == items.length - 1;
        tree(items[i], prefix: isLast ? prefix + "  " : prefix + "├─ ");
      }
    } else if (data is String) {
      print(prefix + inGreen(data));
    } else if (data is int) {
      print(prefix + inYellow(data.toString()));
    } else if (data is double) {
      print(prefix + inYellow(data.toString()));
    } else if (data is bool) {
      print(prefix + inCyan(data.toString()));
    } else if (data is Cell) {
      tree(data.get(), prefix: prefix);
    } else {
      print(prefix + inRed(data.toString()));
    }
  }

  /// click ──╮─→ $tag
  /// on      ╰─→ $id
  /// with    ╰─→ $attributes
  static void click_event(String tag, String id, String attributes) {
    "click".write(inYellow);
    " ──╮─→".write(inRed);
    " $tag".writeLine(inPurple);
    "on".write(inYellow);
    " ╰─→".write(inRed);
    " $id".writeLine(inWhite);
    "with".write(inYellow);
    " ╰─→".write(inRed);
    " $attributes".writeLine(inWhite);
  }

  /// action ──╮─→ $action
  /// on       ╰─→ $node.className
  /// with     ╰─→ $node.nodeId
  /// and      ╰─→ $node.attributes
  static void user_action(String action, Node node) {
    var tag = node.nodeName;
    var id = node.nodeId;
    var attributes = node.attributes;
    "action".write(inYellow);
    " ──╮─→".write(inRed);
    " $action".writeLine(inPurple);
    "on".write(inYellow);
    " ╰─→".write(inRed);
    " $tag".writeLine(inWhite);
    "with".write(inYellow);
    " ╰─→".write(inRed);
    " $id".writeLine(inWhite);
    if (attributes != null) {
      "and".write(inYellow);
      " ╰─→".write(inRed);
      " $attributes".writeLine(inWhite);
    }
  }

  /// set ──╮─→ $selector
  /// value ╰─→ $text
  static void set_value(String selector, String text) {
    "set".write(inYellow);
    " ──╮─→".write(inRed);
    " $selector".writeLine(inPurple);
    "value".write(inGray);
    " ╰─→".write(inRed);
    " $text".writeLine(inGreen);
  }

  /// step ──╮─→ $s ─→ $t
  static void step(String s, String t) {
    "step".write(inYellow);
    " ──╮─→".write(inRed);
    " $s".write(inPurple);
    " ─→".write(inRed);
    " $t".writeLine(inGreen);
  }

  /// $message ──╮─→ $a ─→ $b
  ///            ╰─→ $c ─→ $d
  /// or
  /// $message ─→ $a
  /// or
  /// $message ──╮─→ $a ─→ $b
  ///            ╰─→ $c ─→ $d
  static void action(String message,
      [String? a, String? b, String? c, String? d]) {
    if (a != null && b != null && c != null && d != null) {
      print(inYellow(message) +
          inRed(" ──╮─→ ") +
          inPurple(a) +
          inRed(" ─→ ") +
          inGreen(b));
    }
    if (a != null && b != null && c == null) {
      print(inYellow(message) + inRed(" ─→ ") + inPurple(a));
    }
    if (a != null && b == null && c == null) {
      print(inYellow(message) + inRed(" ─→ ") + inPurple(a));
    }
    if (a != null && b != null && c != null && d != null) {
      print(inYellow(message) +
          inRed(" ──╮─→ ") +
          inPurple(a) +
          inRed(" ─→ ") +
          inGreen(b));
      print(inRed(" ".repeat(message.length)) +
          inRed(" ╰─→ ") +
          inPurple(c) +
          inRed(" ─→ ") +
          inGreen(d));
    }
  }

  /// authenticating ─→ user
  static void authenticating(Authable authable) {
    "authenticating".write(inYellow);
    " ─→ ".write(inRed);
    "${authable.username}".writeLine(inGreen);
  }

  static void visiting(String url) {
    "visiting".write(inYellow);
    " ─→ ".write(inRed);
    "$url".writeLine(inGreen);
  }

  static void scanning(String selector) {
    "scanning".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }

  static void unfocusing(String selector) {
    "unfocusing".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }

  static void setting(String selector, String text, {required bool secret}) {
    "setting".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".write(inPurple);
    " ─→ ".write(inRed);
    if (secret) {
      "********".writeLine(inGreen);
    } else {
      "$text".writeLine(inGreen);
    }
  }

  static void setting_range(String selector, String from, String to) {
    "setting".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".write(inPurple);
    " ─→ ".write(inRed);
    "$from".write(inGreen);
    " ─→ ".write(inRed);
    "$to".writeLine(inGreen);
  }

  static void waiting_for(String selector, String s) {
    "waiting for".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".write(inPurple);
    " ─→ ".write(inRed);
    "$s".writeLine(inGreen);
  }

  static void scrolling(String selector) {
    "scrolling".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }

  static void hover(String selector) {
    "hover".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }

  static void focusing(String selector) {
    "focusing".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }

  static void typing(String selector, String text) {
    "typing".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".write(inPurple);
    " ─→ ".write(inRed);
    "$text".writeLine(inGreen);
  }

  static void executing(String string) {
    "executing".write(inYellow);
    " ─→ ".write(inRed);
    "$string".writeLine(inGreen);
  }

  static void clicking(String selector) {
    "clicking".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }

  static void mouse_enter(String selector) {
    "mouse enter".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }

  static void mouse_leave(String selector) {
    "mouse leave".write(inYellow);
    " ─→ ".write(inRed);
    "$selector".writeLine(inGreen);
  }
}

extension StringEx on String {
  String repeat(int count) {
    return List.filled(count, this).join();
  }
}
