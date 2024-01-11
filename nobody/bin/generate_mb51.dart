import 'package:nobody/lib.dart';

void main() async {
  await generate_mb51_report();
}

Future generate_mb51_report() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransaction("MB51"))
      .click(Sap.Execute)
      .download(DownloadableSapTable(), AbsolutePath("example.xlsx"))
      .wait(Seconds(20));
}
