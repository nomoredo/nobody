//create time report
import 'package:nobody/lib.dart';
import 'package:nobody/references.dart';

Future<void> main() async {
  await create_time_report();
}

Future create_time_report() async {
  return Nobody()
      .online()
      .login(Sap.User('amohandas'))
      .goto(SapTransactionUrl("ZHR076A"))
      // .artificial_delay()
      .set(Sap.Input("Personnel Number"), "9711425")
      .set(Input.WithId("M0:46:::2:34"), "01.01.2016")
      .set(Input.WithId("M0:46:::2:59"), "01.03.2024")
      .click(Sap.Execute)
      .download(Sap.DownloadableTable, AbstractPath.Relative("9713057.xlsx"))
      .wait(Waitable.Seconds(50)) // this was for testing
      .close();
}
