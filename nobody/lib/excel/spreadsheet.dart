import 'package:excel/excel.dart';
import 'package:nobody/references.dart';

typedef Predicate<T> = bool Function(T);
typedef Rows = Iterable<Row>;

@NomoCode()
class Spreadsheet {
  final Sheet sheet;

  const Spreadsheet(this.sheet);

  FutureOr<Rows> rows(Predicate<Row> predicate) async {
    final rows = sheet.rows.map((e) => Row(e));
    return rows.where(predicate);
  }
}
