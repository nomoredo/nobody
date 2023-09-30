abstract class AbstractSelector {
  String get selector;
}

class Css implements AbstractSelector {
  final String selector;

  const Css(this.selector);
}

class XPath implements AbstractSelector {
  final String internal;
  String get selector => 'xpath$internal';
  const XPath(this.internal);
}

/// Button
/// appends button to the selector
class Button implements AbstractSelector {
  final AbstractSelector? inner;
  String get selector =>
      inner == null ? 'button' : 'button[${inner!.selector}]';

  const Button([this.inner]);

  factory Button.WithId(String id) => Button(WithId(id));
  factory Button.WithName(String name) => Button(WithName(name));
  factory Button.WithClass(List<String> classes) => Button(WithClass(classes));
}

/// Input
/// appends input to the selector
class Input implements AbstractSelector {
  final AbstractSelector? inner;
  String get selector => inner == null ? 'input' : 'input[${inner!.selector}]';

  const Input([this.inner]);

  factory Input.WithId(String id) => Input(WithId(id));
  factory Input.WithName(String name) => Input(WithName(name));
  factory Input.WithClass(List<String> classes) => Input(WithClass(classes));
}

/// WithId
/// appends id="{id}" to the selector
class WithId implements AbstractSelector {
  final String id;
  String get selector => 'id="$id"';

  const WithId(this.id);
}

/// WithName
/// appends name="{name}" to the selector
class WithName implements AbstractSelector {
  final String name;
  String get selector => 'name="$name"';

  const WithName(this.name);
}

/// WithClass
/// appends class="{class}" to the selector
/// class can be a list of classes
class WithClass implements AbstractSelector {
  final List<String> classes;
  String get selector => 'class="${classes.join(' ')}"';

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
