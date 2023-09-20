import 'package:nobody/nobody.dart';
import 'package:nobody/nobody.future.dart';

void main(List<String> arguments) async {
  var online = await Nobody.online()
      .visit('https://www.google.com')
      .type('input[name=q]', 'dartlang')
      .click('input[type=submit]')
      .waitFor('h3.LC20lb')
      .has('h3.LC20lb', 'Dart programming language - Dart')
      .close();
  print('DONE');
}
