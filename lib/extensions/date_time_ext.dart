import 'package:intl/intl.dart';

class DateFormatPatterns {
  static const String fullDayMonthYear = 'EEEE, MMMM dd';
}

extension DateTimeExtension on DateTime {
  String toFormattedFullDayMonthYear() {
    return DateFormat(DateFormatPatterns.fullDayMonthYear).format(this);
  }
}
