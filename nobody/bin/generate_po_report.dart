import 'package:nobody/lib.dart';

void main() async {
  await po_export();
}

Future po_export() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(Sap.Transaction("ME2N"))
      .set(SapInput('Purchasing organization'), '2200')
      .set_range(
          SapInput('Purchasing Document Date'), '01.01.2023', '30.06.2023')
      .set(SapInput("Plant"), "22A2")
      .set(SapInput("Purchasing Group"), "161")
      .click(SapButton("Execute (F8)"))
      .download(DownloadableSapTable(), AbsolutePath("example.xlsx"))
      .wait(Seconds(20));
}
