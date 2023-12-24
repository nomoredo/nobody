import 'package:nobody/src/rust/api/simple.dart';
import 'package:nobody/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  var s = await myCustomFunc(a: 1, b: 2);
  print(s);
}
