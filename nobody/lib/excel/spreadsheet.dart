import 'package:excel/excel.dart';
import 'package:nobody/references.dart';

typedef Predicate<T> = bool Function(T);
typedef Rows = Iterable<Row>;

@NomoCode()
class Spreadsheet {
  final Sheet sheet;
  final Workbook workbook;

  const Spreadsheet(this.sheet, this.workbook);

  FutureOr<Rows> rows(Predicate<Row> predicate) async {
    final rows = sheet.rows.map((e) => Row(e, this));
    return rows.where(predicate);
  }

  FutureOr<Rows> rows_not_empty() async {
    final rows = sheet.rows.map((e) => Row(e, this));
    return rows.where((r) => r.cells.any((c) => c != null));
  }
}
