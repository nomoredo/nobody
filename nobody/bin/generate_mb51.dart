import 'package:nobody/lib.dart';
import 'package:nobody/references.dart';

void main() async {
  await generate_mb51_report();
}

Future generate_mb51_report() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransactionUrl("MB51"))
      .click(Sap.Execute)
      .download(DownloadableSapTable2(), AbsolutePath("example.xlsx"));
  // .wait(Seconds(20));
}
