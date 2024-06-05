// extensions on DateTime
extension DateExt on DateTime {
  // yyyyMMdd
  String get file_string => this.toString().split(' ')[0].replaceAll('-', '');
}
