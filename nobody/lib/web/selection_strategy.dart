abstract class SelectionStrategy {
  String getSelectionScript();
}

class ByIndex implements SelectionStrategy {
  final int index;

  ByIndex(this.index);

  @override
  String getSelectionScript() {
    return 'element.selectedIndex = $index;';
  }
}

class ByText implements SelectionStrategy {
  final String text;

  ByText(this.text);

  @override
  String getSelectionScript() {
    return '''
      var options = element.options;
      for (var i = 0; i < options.length; i++) {
        if (options[i].text.trim() === "$text") {
          element.selectedIndex = i;
          break;
        }
      }
    ''';
  }
}
