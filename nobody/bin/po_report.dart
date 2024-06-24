import 'package:nobody/lib.dart';

void main() async {
  await po_export();
}

Future po_export() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransactionUrl("ME2N"))
      .set(SapInput('Purchasing organization'),
          '') // include 2000 , 2200 and others
      .set_range(
          SapInput('Purchasing Document Date'), '01.01.2023', '30.12.2025')
      .set_range(SapInput("Plant"), "2200", "22A2")
      .set(SapInput("Purchasing Group"), "")
      .click(SapButton("Execute (F8)"))
      .download(Sap.DownloadableTable,
          AbsolutePath("PO REPORT${DateTime.now().file_string}.xlsx"));
  // .wait(Seconds(20));
}
