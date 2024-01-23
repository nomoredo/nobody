import 'any_selector.dart';

class Css implements AnySelector {
  final String selector;

  const Css(this.selector);
}

class XPath implements AnySelector {
  final String internal;
  String get selector => 'xpath="$internal"';
  const XPath(this.internal);
}

/// Button
/// appends button to the selector
class Button implements AnySelector {
  final AnySelector? inner;
  String get selector =>
      inner == null ? 'button' : 'button[${inner!.selector}]';

  const Button([this.inner]);

  factory Button.WithId(String id) => Button(WithId(id));
  factory Button.WithName(String name) => Button(WithName(name));
  factory Button.WithClass(List<String> classes) => Button(WithClass(classes));
}

/// Input
/// appends input to the selector
class Input implements AnySelector {
  final AnySelector? inner;
  String get selector => inner == null ? 'input' : 'input[${inner!.selector}]';

  const Input([this.inner]);

  factory Input.WithId(String id) => Input(WithId(id));
  factory Input.WithName(String name) => Input(WithName(name));
  factory Input.WithClass(List<String> classes) => Input(WithClass(classes));
}

/// TextArea
/// appends textarea to the selector
class TextArea implements AnySelector {
  final AnySelector? inner;
  String get selector =>
      inner == null ? 'textarea' : 'textarea[${inner!.selector}]';

  const TextArea([this.inner]);

  factory TextArea.WithId(String id) => TextArea(WithId(id));
  factory TextArea.WithName(String name) => TextArea(WithName(name));
  factory TextArea.WithClass(List<String> classes) =>
      TextArea(WithClass(classes));
}

/// WithId
/// appends id="{id}" to the selector
class WithId implements AnySelector {
  final String id;
  String get selector => 'id="$id"';

  const WithId(this.id);
}

/// WithName
/// appends name="{name}" to the selector
class WithName implements AnySelector {
  final String name;
  String get selector => 'name="$name"';

  const WithName(this.name);
}

/// WithClass
/// appends class="{class}" to the selector
/// class can be a list of classes
class WithClass implements AnySelector {
  final List<String> classes;
  String get selector => 'class="${classes.join(' ')}"';

  const WithClass(this.classes);
}

/// SapInput
/// has name="InputField" and title="{label}""
class SapInput implements AnySelector {
  final String label;
  String get selector => 'input[name="InputField"][title="$label"]';
  static AnySelector All() => Css('input[class^="lsField__input"]');
  const SapInput(this.label);
}

void Print(dynamic text) {
  if (text is Map<String, dynamic>) {
    for (var entry in text.entries) {
      print('${entry.key} : ${entry.value}');
    }
  } else {
    print(text);
  }
}

/// SapButton
/// has role="button", class="lsButton and title="{label}"
class SapButton implements AnySelector {
  final String label;
  String get selector => 'div[role="button"][title="$label"]';

  const SapButton(this.label);
}

/// SapTable
/// role="grid" class="urSTCS lsSapTable--backgroundColor urHtmlTableReset lsSapTable--bs-disabled"
class SapTable implements AnySelector {
  final String label;
  String get selector =>
      'div[role="grid"][class="urSTCS lsSapTable--backgroundColor urHtmlTableReset lsSapTable--bs-disabled"]';

  const SapTable(this.label);
}

/// SapTableRow
/// a span with title="{label}" inside  role="row" aria-rowindex="{index}" inside a div with role="grid"
class SapTableHead implements AnySelector {
  String get selector =>
      'th[role="columnheader"][lsmatrixcolindex="0"][lsmatrixrowindex="0"]';

  const SapTableHead();
}
