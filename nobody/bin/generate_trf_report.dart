import 'package:nobody/lib.dart';

void main() async {
  await generate_trf_report();
}

Future generate_trf_report() async {
  return Nobody()
      .online()
      .login(Sap('amohandas'))
      .goto(Transaction("ZTR01"))
      .map(SapInputFields, Print)
      .set(SapInput('Company Code'), '2200')
      .click(SapButton("Execute (F8)"))
      .download(DownloadableSapTable(), SimplePath("example.xlsx"))
      .wait(Seconds(20));
}
