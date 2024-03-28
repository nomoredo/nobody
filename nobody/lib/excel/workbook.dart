import 'package:excel/excel.dart';
import 'package:nobody/references.dart';

@NomoCode()
class Workbook {
  final Excel excel;

  const Workbook(this.excel);

  Future<Spreadsheet> sheet(String name) async {
    final sheet = excel.tables[name];
    if (sheet == null) {
      Show.error("Sheet $name not found");
      throw Exception("Sheet $name not found");
    }
    return Spreadsheet(sheet, this);
  }
}
