//create time report
import 'package:nobody/lib.dart';
import 'package:nobody/references.dart';

Future<void> main() async {
  await create_time_report();
}

Future create_time_report() async {
  var excel = await nobody
      .open(ExcelFile("emplist.xlsx"))
      .sheet("Sheet1")
      .rows((x) => x[2].is_not_empty)
      .skip(1)
      .map((x) => x[2].toString());

  for (var emp in excel) {
    try {
      await Nobody()
          .online()
          .login(Sap.User('amohandas'))
          .goto(SapTransactionUrl("ZHR076A"))
          // .artificial_delay()
          .set(Sap.Input("Personnel Number"), emp)
          .set(Input.WithId("M0:46:::2:34"), "01.01.2016")
          .set(Input.WithId("M0:46:::2:59"), "01.03.2024")
          .click(Sap.Execute)
          .download(Sap.DownloadableTable, AbstractPath.Absolute("$emp.xlsx"))
          .wait(Waitable.Seconds(5))
          .close();
    } catch (e) {
      print(e);
    }
  }
}
