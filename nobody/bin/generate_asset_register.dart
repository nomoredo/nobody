import 'package:nobody/lib.dart';
import 'package:nobody/references.dart';

void main() async {
  await generate_asset_report();
}

Future generate_asset_report() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransactionUrl("AR01"))
      // .set_range(SapInput('Plant'), '2200', '22A2')
      .set(SapInput("Plant"), "22a1")
      .click(Sap.Execute)
      .download(DownloadableSapTable(), AbsolutePath("FAR2200.xlsx"));
  // .wait(Seconds(20));
}
