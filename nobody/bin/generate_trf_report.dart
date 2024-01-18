import 'package:nobody/lib.dart';

void main() async {
  await generate_trf_report();
}

Future generate_trf_report() async {
  var something = await Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransaction("ZTR01"))
      // .listen()
      .set(SapInput('Company Code'), '2200')
      // .start_record()
      .wait(Seconds(20))
      // .stop_record("test.json")
      .close();
  // .click(SapButton("Execute (F8)"))
  // .waitFor(SapButton("Back (F3)"))
  // .download(DownloadableSapTable(), SimplePath("example.xlsx"))
  // .wait(Seconds(20));

  // .set(SapInput('Company Code'), '2200')
  // .click(SapButton("Execute (F8)"))
  // .download(DownloadableSapTable(), SimplePath("example.xlsx"))
  // .wait(Seconds(20));

  print(something);
}
