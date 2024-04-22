import 'package:nobody/references.dart';

void main() async {
  await generate_mb51_report();
}

Future generate_mb51_report() async {
  final today = DateTime.now().to_yyyyMMdd();
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransactionUrl("MB51"))
      .sets(SapInput("Plant"), ["2200", "22A2"])
      .sets(SapInput('Posting Date in the Document'),
          ["01.01.2022", "31.12.2025"])
      .click(Sap.Execute)
      .download(DownloadableSapTable2(), AbsolutePath("MB51 ${today}.xlsx"));
  // .wait(Seconds(20));
}
