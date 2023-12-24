import 'package:nobody/lib.dart';

Future<void> main() async {
  await RustLib.init();
  var s = await myCustomFunc(a: 1, b: 2);
  print(s);
  await show(name: 'hello');
  var files = await getFiles();
  print(files);
  print(s);

  var browwer = await initDriver();
  // await browwer.get('https://www.baidu.com');
}
