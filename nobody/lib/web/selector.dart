abstract class AbstractSelector {
  String get selector;
}

class Css implements AbstractSelector {
  final String selector;

  const Css(this.selector);
}

class XPath implements AbstractSelector {
  final String internal;
  String get selector => 'xpath="$internal"';
  const XPath(this.internal);
}

class NestedSelector implements AbstractSelector {
  final AbstractSelector outer;
  final AbstractSelector inner;
  String get selector => '${outer.selector} ${inner.selector}';
  const NestedSelector(this.outer, this.inner);
}

/// Button
/// appends button to the selector
class Button implements AbstractSelector {
  final AbstractSelector? inner;
  String get selector => inner == null ? 'button' : 'button${inner!.selector}';

  const Button([this.inner]);

  factory Button.WithId(String id) => Button(WithId(id));
  factory Button.WithName(String name) => Button(WithName(name));
  factory Button.WithClass(List<String> classes) => Button(WithClass(classes));
  factory Button.WithText(String text) => Button(WithText(text));
}

/// Input
/// appends input to the selector
class Input implements AbstractSelector {
  final AbstractSelector? inner;
  String get selector => inner == null ? 'input' : 'input${inner!.selector}';

  const Input([this.inner]);

  factory Input.WithId(String id) => Input(WithId(id));
  factory Input.WithName(String name) => Input(WithName(name));
  factory Input.WithClass(List<String> classes) => Input(WithClass(classes));
  factory Input.WithText(String text) => Input(WithText(text));
}

/// TextArea
/// appends textarea to the selector
class TextArea implements AbstractSelector {
  final AbstractSelector? inner;
  String get selector =>
      inner == null ? 'textarea' : 'textarea${inner!.selector}';

  const TextArea([this.inner]);

  factory TextArea.WithId(String id) => TextArea(WithId(id));
  factory TextArea.WithName(String name) => TextArea(WithName(name));
  factory TextArea.WithClass(List<String> classes) =>
      TextArea(WithClass(classes));
  factory TextArea.WithText(String text) => TextArea(WithText(text));
}

/// Div
class Div implements AbstractSelector {
  final AbstractSelector? inner;
  String get selector => inner == null ? 'div' : 'div${inner!.selector}';

  const Div([this.inner]);

  factory Div.WithId(String id) => Div(WithId(id));
  factory Div.WithName(String name) => Div(WithName(name));
  factory Div.WithClass(List<String> classes) => Div(WithClass(classes));
  factory Div.WithText(String text) => Div(WithText(text));
}

/// With Text
/// appends text="{text}" to the selector
class WithText implements AbstractSelector {
  final String text;
  String get selector => '[text="$text"]';

  const WithText(this.text);
}

/// WithId
/// appends id="{id}" to the selector
class WithId implements AbstractSelector {
  final String id;
  String get clean_id => id
      .replaceAll(':', '\\:')
      .replaceAll('.', '\\.')
      .replaceAll(',', '\\,')
      .replaceAll('[', '\\[')
      .replaceAll(']', '\\]')
      .replaceAll('#', '\\#')
      .replaceAll(' ', '\\ ')
      .replaceAll('(', '\\(')
      .replaceAll(')', '\\)');

  String get selector => '[id="$clean_id"]';

  const WithId(this.id);
}

/// WithName
/// appends name="{name}" to the selector
class WithName implements AbstractSelector {
  final String name;
  String get selector => '[name="$name"]';

  const WithName(this.name);
}

/// WithClass
/// appends class="{class}" to the selector
/// class can be a list of classes
class WithClass implements AbstractSelector {
  final List<String> classes;
  String get selector => '[class="${classes.join(' ')}"]';

  const WithClass(this.classes);
}

/// SapInput
/// has name="InputField" and title="{label}""
class SapInput implements AbstractSelector {
  final String label;
  String get selector => 'input[name="InputField"][title="$label"]';
  static AbstractSelector All() => Css('input[class^="lsField__input"]');
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
class SapButton implements AbstractSelector {
  final String label;
  String get selector => 'div[role="button"][title="$label"]';

  const SapButton(this.label);
}

/// SapTable
/// role="grid" class="urSTCS lsSapTable--backgroundColor urHtmlTableReset lsSapTable--bs-disabled"
class SapTable implements AbstractSelector {
  final String label;
  String get selector =>
      'div[role="grid"][class="urSTCS lsSapTable--backgroundColor urHtmlTableReset lsSapTable--bs-disabled"]';

  const SapTable(this.label);
}

/// SapTableRow
/// a span with title="{label}" inside  role="row" aria-rowindex="{index}" inside a div with role="grid"
class SapTableHead implements AbstractSelector {
  String get selector =>
      'th[role="columnheader"][lsmatrixcolindex="0"][lsmatrixrowindex="0"]';

  const SapTableHead();
}
