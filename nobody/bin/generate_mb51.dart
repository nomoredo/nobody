import 'package:nobody/lib.dart';

void main() async {
  await generate_mb51_report();
}

Future generate_mb51_report() async {
  return Nobody()
      .online()
      .login(Sap('amohandas'))
      .goto(Transaction("MB51"))
      .click(SapButton("Execute (F8)"))
      .download(DownloadableSapTable(), SimplePath("example.xlsx"))
      .wait(Seconds(20));
}
