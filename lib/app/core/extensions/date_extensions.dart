import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toFormatDDMMYYYY() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String toWrittenFormat() {
    return DateFormat('d MMM, yyyy').format(this);
  }

  String monthDateYearWrittenFormate() {
    return DateFormat('MMM d, yyyy').format(this);
  }

  String monthName() {
    return DateFormat('MMM yyyy').format(this);
  }

  String monthNameOnly() {
    return DateFormat('MMMM').format(this);
  }

  String yearNameOnly() {
    return DateFormat('yyyy').format(this);
  }

  double get toCompareValueForMonth => year + month / 12;

  bool isBeforeMonth(DateTime time) =>
      toCompareValueForMonth < time.toCompareValueForMonth;

  bool isAfterMonth(DateTime time) =>
      toCompareValueForMonth > time.toCompareValueForMonth;

  DateTime get previousMonth => DateTime(year, month - 1);

  DateTime get nextMonth => DateTime(year, month + 1);

  DateTime get startDateOfMonth => DateTime(year, month);

  DateTime get endDateOfMonth =>
      DateTime(year, month + 1).subtract(const Duration(seconds: 1));

  DateTime get onlyDate => DateTime(year, month, day);

  String get monthDayFormat => DateFormat('MM-dd').format(this);

  int get dayCount {
    return lastDateOfTheMonth.day;
  }

  bool sameDate(DateTime? date) {
    if (date == null) return false;
    return date.day == day && date.month == month && date.year == year;
  }

  bool isAfterDate(DateTime? date) {
    if (date == null) return false;
    return date.year < year ||
        (date.month < month && date.year == year) ||
        (date.day < day && date.month == month && date.year == year);
  }

  bool isBeforeDate(DateTime? date) {
    if (date == null) return false;
    return date.year > year ||
        (date.month > month && date.year == year) ||
        (date.day > day && date.month == month && date.year == year);
  }

  DateTime get startDateOfTheMonth {
    return DateTime(year, month);
  }

  DateTime get lastDateOfTheMonth {
    return DateTime(year, month + 1).subtract(const Duration(days: 1));
  }

  toDateString() {
    return DateFormat("d MMM yy").format(this);
  }
}
