import 'references.dart';

abstract class AbstractUrl {
  String get url;
}

class Transaction implements AbstractUrl {
  final String code;
  String get url =>
      'https://cbs.almansoori.biz/sap/bc/gui/sap/its/webgui/?sap-client=800&~TRANSACTION=$code#';
  const Transaction(this.code);
}

class Url implements AbstractUrl {
  final String url;

  const Url(this.url);
}

abstract class AbsractSelector {
  String get selector;
}

class Css implements AbsractSelector {
  final String selector;

  const Css(this.selector);
}

/// Button
/// appends button to the selector
class Button implements AbsractSelector {
  final AbsractSelector? inner;
  String get selector =>
      inner == null ? 'button' : 'button[${inner!.selector}]';

  const Button([this.inner]);

  factory Button.WithId(String id) => Button(WithId(id));
  factory Button.WithName(String name) => Button(WithName(name));
  factory Button.WithClass(List<String> classes) => Button(WithClass(classes));
}

/// Input
/// appends input to the selector
class Input implements AbsractSelector {
  final AbsractSelector? inner;
  String get selector => inner == null ? 'input' : 'input[${inner!.selector}]';

  const Input([this.inner]);

  factory Input.WithId(String id) => Input(WithId(id));
  factory Input.WithName(String name) => Input(WithName(name));
  factory Input.WithClass(List<String> classes) => Input(WithClass(classes));
}

/// WithId
/// appends id="{id}" to the selector
class WithId implements AbsractSelector {
  final String id;
  String get selector => 'id="$id"';

  const WithId(this.id);
}

/// WithName
/// appends name="{name}" to the selector
class WithName implements AbsractSelector {
  final String name;
  String get selector => 'name="$name"';

  const WithName(this.name);
}

/// WithClass
/// appends class="{class}" to the selector
/// class can be a list of classes
class WithClass implements AbsractSelector {
  final List<String> classes;
  String get selector => 'class="${classes.join(' ')}"';

  const WithClass(this.classes);
}

/// SapInput
/// has name="InputField" and title="{label}""
class SapInput implements AbsractSelector {
  final String label;
  String get selector => 'input[name="InputField"][title="$label"]';

  const SapInput(this.label);
}

/// SapButton
/// has role="button", class="lsButton and title="{label}"
class SapButton implements AbsractSelector {
  final String label;
  String get selector => 'div[role="button"][class="lsButton"][title="$label"]';

  const SapButton(this.label);
}

/// SapTable
/// role="grid" class="urSTCS lsSapTable--backgroundColor urHtmlTableReset lsSapTable--bs-disabled"
class SapTable implements AbsractSelector {
  final String label;
  String get selector =>
      'div[role="grid"][class="urSTCS lsSapTable--backgroundColor urHtmlTableReset lsSapTable--bs-disabled"]';

  const SapTable(this.label);
}

/// SapTableRow
/// a span with title="{label}" inside  role="row" aria-rowindex="{index}" inside a div with role="grid"
class SapTableRow implements AbsractSelector {
  final String label;
  final int index;
  String get selector =>
      'div[role="grid"] > div[role="row"][aria-rowindex="$index"] > span[title="$label"]';

  const SapTableRow(this.label, [this.index = 1]);
}

abstract class Text {
  String get text;
}

abstract class Attribute {
  String get attribute;
}

abstract class Timeout {
  Duration get timeout;
}

abstract class X {
  int get x;
}

class Nobody {
  static Future<Online> online({bool visible = true, bool slow = false}) async {
    var browser = await puppeteer.launch(
        headless: !visible,
        noSandboxFlag: true,
        slowMo: Duration(milliseconds: slow ? 1000 : 0));
    return Online(browser);
  }
}
