import 'package:excel/excel.dart';
import 'package:nobody/references.dart';

@NomoCode()
class Row {
  final List<Data?> cells;

  const Row(this.cells);

  Cell operator [](int index) => Cell(cells[index]);

  Cell? get first => Cell(cells.first);

  String string(int index) =>
      this.cells.elementAt(index)?.value?.toString() ?? '';

  String get text => this.cells.map((e) => e?.value ?? '').join(' ');

  String string_or(int index, String defaultValue) =>
      this.cells.elementAt(index)?.value ?? defaultValue;

  int? integer(int index) =>
      int.tryParse(this.cells.elementAt(index)?.value ?? '');

  int integer_or(int index, int defaultValue) =>
      int.tryParse(this.cells.elementAt(index)?.value ?? '') ?? defaultValue;

  double? double_(int index) =>
      double.tryParse(this.cells.elementAt(index)?.value ?? '');

  double double_or(int index, double defaultValue) =>
      double.tryParse(this.cells.elementAt(index)?.value ?? '') ?? defaultValue;

  bool boolean(int index) => this.cells.elementAt(index)?.value == 'TRUE';
}

extension ExIterable<T> on FutureOr<Iterable<T>> {
  FutureOr<Iterable<T>> where(Predicate<T> predicate) async {
    return (await this).where(predicate);
  }

  FutureOr<Iterable<U>> map<U>(U Function(T) f) async {
    return (await this).map(f);
  }

  FutureOr<Iterable<T>> skip(int count) async {
    return (await this).skip(count);
  }

  FutureOr<Iterable<T>> take(int count) async {
    return (await this).take(count);
  }

  FutureOr<Iterable<T>> skipWhile(Predicate<T> predicate) async {
    return (await this).skipWhile(predicate);
  }

  FutureOr<Iterable<T>> takeWhile(Predicate<T> predicate) async {
    return (await this).takeWhile(predicate);
  }

  FutureOr<Iterable<T>> whereType<T>() async {
    return (await this).whereType<T>();
  }

  FutureOr<Iterable<T>> followedBy(Iterable<T> other) async {
    return (await this).followedBy(other);
  }

  //filterMap
  FutureOr<Iterable<U>> mapWhere<U>(
      Predicate<T> predicate, U Function(T) f) async {
    return (await this).where(predicate).map(f);
  }

  FutureOr<Iterable<U>> expand<U>(Iterable<U> Function(T) f) async {
    return (await this).expand(f);
  }
}
