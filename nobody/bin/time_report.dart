//create time report
import 'package:nobody/lib.dart';
import 'package:nobody/references.dart';

Future<void> main() async {
  await create_time_report();
}

Future create_time_report() async {
  var excel = await nobody
      .open(ExcelFile("./EMP.xlsx"))
      .sheet("Sheet1")
      .rows((x) => x[0].is_not_empty && x[1].is_empty)
      .map((x) => x[0].toString());

  for (var name in excel) {
    try {
      await nobody
          .online()
          .login(SapUser('amohandas'))
          .goto(SapTransactionUrl("ZHR076A"))
          .set(Sap.Input("Personnel Number"), name)
          .set(Input.WithId("M0:46:::2:34"), "01.01.2016")
          .set(Input.WithId("M0:46:::2:59"), "20.03.2024")
          .click(Sap.Execute)
          .download(Sap.DownloadableTable, AbstractPath.Absolute("$name.xlsx"))
          .wait(Waitable.Seconds(10))
          .close();
    } catch (e) {
      print(e);
    }
  }
}

extension ForEveryExtension on Future<Online> {
  Future<Online> for_each<T>(
      Iterable<T> list, FutureOr<Online> Function(Online, T) action) async {
    var online = await this;
    for (var item in list) {
      try {
        online = await action(online, item);
      } catch (e) {
        print(e);
      }
    }
    return online;
  }
}
