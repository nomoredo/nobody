///generic extensions for numbers that convert them to durations
///e.g. 5.minutes
///     5.seconds
///    5.milliseconds
extension ExDuration on num {
  Duration get seconds => Duration(seconds: this.toInt());
  Duration get minutes => Duration(minutes: this.toInt());
  Duration get milliseconds => Duration(milliseconds: this.toInt());
}

/// String extensions
extension ExString on String? {
  /// Returns true if the string is null or empty.
  bool get is_empty => this == null || this!.isEmpty;
  bool get is_not_empty => !is_empty;

  String? exclude(String exclude) {
    return this?.replaceAll(exclude, '');
  }

  String? get capitalize {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.substring(0, 1).toUpperCase() + this!.substring(1);
  }

  String? get capitalize_first {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.substring(0, 1).toUpperCase() + this!.substring(1);
  }

  String? get snake_case {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!
        .replaceAllMapped(
            RegExp(r'[A-Z]'), (Match m) => '_${m[0]!.toLowerCase()}')
        .toLowerCase()
        .trim();
  }

  String? get camel_case {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!
        .replaceAllMapped(RegExp(r'_[a-z]'), (Match m) => m[0]!.toUpperCase())
        .replaceAll('_', '')
        .trim();
  }

  String? get title_case {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!
        .replaceAllMapped(
            RegExp(r'[A-Z]'), (Match m) => ' ${m[0]!.toLowerCase()}')
        .replaceAllMapped(RegExp(r'^[a-z]'), (Match m) => m[0]!.toUpperCase())
        .trim();
  }

  String? get titleCase {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!
        .replaceAllMapped(
            RegExp(r'[A-Z]'), (Match m) => ' ${m[0]!.toLowerCase()}')
        .replaceAllMapped(RegExp(r'^[a-z]'), (Match m) => m[0]!.toUpperCase())
        .trim();
  }

  String? get title_case_words {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!
        .replaceAllMapped(
            RegExp(r'[A-Z]'), (Match m) => ' ${m[0]!.toLowerCase()}')
        .replaceAllMapped(RegExp(r'^[a-z]'), (Match m) => m[0]!.toUpperCase())
        .trim();
  }

  bool has(String? value) {
    if (this == null) return false;
    if (this!.isEmpty) return false;
    return this!.contains(value!);
  }

  bool hasAny(List<String> values) {
    if (this == null) return false;
    if (this!.isEmpty) return false;
    for (var value in values) {
      if (this!.contains(value)) return true;
    }
    return false;
  }

  bool hasAll(List<String> values) {
    if (this == null) return false;
    if (this!.isEmpty) return false;
    for (var value in values) {
      if (!this!.contains(value)) return false;
    }
    return true;
  }

  bool hasNumber() {
    if (this == null) return false;
    if (this!.isEmpty) return false;
    return this!.contains(RegExp(r'[0-9]'));
  }

  bool hasSpecialCharacters() {
    if (this == null) return false;
    if (this!.isEmpty) return false;
    return this!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  String? remove(String remove) {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.replaceAll(remove, '');
  }

  String? clean_url() {
    return this.remove('http://').remove('https://').remove('www.').shorten(50);
  }

  /// center a string to a given length
  /// add spaces to the left and right of the string
  /// e.g. "1234567890" -> "  1234567890  "
  String? center(int length) {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    if (this!.length >= length) return this;
    var left = (length - this!.length) ~/ 2;
    var right = length - this!.length - left;
    return ' ' * left + this! + ' ' * right;
  }

  /// shorten a string to a given length
  /// split the string in half and add ... in the middle
  /// e.g. "1234567890" -> "123...890"
  String? shorten(int length) {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    if (this!.length <= length) return this;
    var half = length ~/ 2;
    return this!.substring(0, half) +
        '...' +
        this!.substring(this!.length - half);
  }

  bool is_longer_than(int length) {
    return this.len > length;
  }

  bool is_shorter_than(int length) {
    return this.len < length;
  }

  bool is_length(int length) {
    return this.len == length;
  }

  bool is_length_between(int min, int max) {
    return this.len >= min && this.len <= max;
  }

  int get len => this?.length ?? 0;

  String? removeFirst(String remove) {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.replaceFirst(remove, '');
  }

  String? removeLast(String remove) {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.replaceFirst(remove, '');
  }

  String? removeNumbers() {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.replaceAll(RegExp(r'[0-9]'), '');
  }

  String? removeSpecialCharacters() {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.replaceAll(RegExp(r'[!@#$%^&*(),.?":{}|<>]'), '');
  }

  String? removeSpaces() {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this!.replaceAll(' ', '');
  }

  String? obscure({int start = 0, int end = 0, String obscureWith = '*'}) {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    if (start < 0) start = 0;
    if (end < 0) end = 0;
    if (start + end > this!.length) {
      start = 0;
      end = 0;
    }
    var obscured = this!.substring(0, start);
    for (var i = 0; i < this!.length - start - end; i++) {
      obscured += obscureWith;
    }
    obscured += this!.substring(this!.length - end);
    return obscured;
  }
}

/// Number extensions
extension ExNumber on num? {
  num get orZero => this ?? 0;
  bool get isZero => this?.toInt() == 0;
  bool get isNotZero => !isZero;
  bool get isMoreThanZero => isNotZero;
  bool get isLessThanZero => this.orZero < 0;
  bool get isMoreThanOne => this.orZero > 1;
  bool get isLessThanOne => this.orZero < 1;
  bool get isOne => this.orZero == 1;

  bool isMoreThan(num? other) => this.orZero > other.orZero;
  bool isLessThan(num? other) => this.orZero < other.orZero;
  bool isMoreThanOrEqualTo(num? other) => this.orZero >= other.orZero;
  bool isLessThanOrEqualTo(num? other) => this.orZero <= other.orZero;

  num? get abs => this?.abs();
  num? get ceil => this?.ceil();
  num? get floor => this?.floor();
  num? get round => this?.round();
  num? get truncate => this?.truncate();
  num? get toDouble => this?.toDouble();
  num? get toInt => this?.toInt();
  num? get toNum => this?.toDouble();
}

/// DateTime extensions
extension ExDateTime on DateTime {
  bool get isToday {
    var now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  bool get isYesterday {
    var now = DateTime.now();
    var yesterday = now.subtract(Duration(days: 1));
    return yesterday.year == year &&
        yesterday.month == month &&
        yesterday.day == day;
  }

  bool get isTomorrow {
    var now = DateTime.now();
    var tomorrow = now.add(Duration(days: 1));
    return tomorrow.year == year &&
        tomorrow.month == month &&
        tomorrow.day == day;
  }

  bool get isThisYear {
    var now = DateTime.now();
    return now.year == year;
  }

  bool get isThisMonth {
    var now = DateTime.now();
    return now.year == year && now.month == month;
  }

  bool get isThisWeek {
    var now = DateTime.now();
    var week = now.subtract(Duration(days: 7));
    return isAfter(week);
  }

  bool get isThisHour {
    var now = DateTime.now();
    return now.year == year &&
        now.month == month &&
        now.day == day &&
        now.hour == hour;
  }

  bool get isThisMinute {
    var now = DateTime.now();
    return now.year == year &&
        now.month == month &&
        now.day == day &&
        now.hour == hour &&
        now.minute == minute;
  }

  bool get isThisSecond {
    var now = DateTime.now();
    return now.year == year &&
        now.month == month &&
        now.day == day &&
        now.hour == hour &&
        now.minute == minute &&
        now.second == second;
  }

  bool isAfter(DateTime other) => isAfter(other);
  bool isBefore(DateTime other) => isBefore(other);
  bool isAtSameMomentAs(DateTime other) => isAtSameMomentAs(other);

  DateTime addYears(int years) => add(Duration(days: years * 365));
  DateTime addMonths(int months) => add(Duration(days: months * 30));
  DateTime addWeeks(int weeks) => add(Duration(days: weeks * 7));
  DateTime addDays(int days) => add(Duration(days: days));
  DateTime addHours(int hours) => add(Duration(hours: hours));
  DateTime addMinutes(int minutes) => add(Duration(minutes: minutes));
  DateTime addSeconds(int seconds) => add(Duration(seconds: seconds));
  DateTime addMilliseconds(int milliseconds) =>
      add(Duration(milliseconds: milliseconds));

  /// to dd.MM.yyyy
  String to_ddMMyyyy() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year}';
  }
}
