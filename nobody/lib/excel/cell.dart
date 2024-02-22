import 'package:excel/excel.dart';
import 'package:nobody/references.dart';

@NomoCode()
class Cell {
  final Data? data;

  const Cell(this.data);

  T? get<T>() => data?.value as T?;

  String get text => data?.value.toString() ?? "";

  bool get is_empty => data == null || data!.value == null || data!.value == "";

  bool get is_not_empty => !is_empty;

  bool get is_number => data?.value is num;

  bool get is_string => data?.value is String;

  bool get is_date => data?.value is DateTime;

  bool get is_bool => data?.value is bool;

  bool get is_formula => data?.value is Formula;

  bool get is_error => data?.value is Error;

  @override
  String toString() {
    return text;
  }
}
