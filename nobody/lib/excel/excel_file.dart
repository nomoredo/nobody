import 'package:excel/excel.dart';
import 'package:nobody/references.dart';

@NomoCode()
class ExcelFile implements AnyFile<Workbook> {
  final String path;

  const ExcelFile(this.path);

  @override
  Future<Workbook> open() async {
    if (!File(path).existsSync()) {
      Show.error("File $path not found");
      throw Exception("File $path not found");
    }
    Show.action("OPENING", "EXCEL FILE", path);
    final stream = File(path).readAsBytesSync();
    final excel = Excel.decodeBytes(stream);
    return Workbook(excel);
  }
}
