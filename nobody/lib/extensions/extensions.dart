///generic extensions for numbers that convert them to durations
///e.g. 5.minutes
///     5.seconds
///    5.milliseconds
extension ExDuration on num {
  Duration get seconds => Duration(seconds: this.toInt());
  Duration get minutes => Duration(minutes: this.toInt());
  Duration get milliseconds => Duration(milliseconds: this.toInt());
}
