import 'package:excel/excel.dart';
import 'package:nobody/references.dart';

@NomoCode()
class Cell {
  final Data? data;

  const Cell(this.data);

  T? get<T>() => data?.value as T?;

  String get text => data?.value.toString() ?? "";

  bool get is_empty => data == null || data!.value == null || data!.value == "";

  @override
  String toString() {
    return text;
  }
}
