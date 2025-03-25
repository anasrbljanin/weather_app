class DateHelper {
  static String getMonthString(int? month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'No month';
    }
  }

  static String getWeekdayString(int? day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return 'Day missing';
    }
  }
}

extension FormatDate on DateTime? {
  String formatTime() {
    return this != null
        ? '${this!.hour > 9 ? '' : '0'}${this!.hour.toString()}:${this!.minute > 9 ? '' : '0'}${this!.minute.toString()}'
        : 'No time';
  }

  bool isBetween(DateTime? fromDateTime, DateTime? toDateTime) {
    if (this != null && fromDateTime != null && toDateTime != null) {
      return this!.isAfter(fromDateTime) && this!.isBefore(toDateTime);
    }
    return false;
  }

  bool isAfterOrEqualTo(DateTime dateTime) {
    if (this != null) {
      return dateTime.isAtSameMomentAs(this!) || this!.isAfter(dateTime);
    }
    return false;
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    if (this != null) {
      return dateTime.isAtSameMomentAs(this!) || this!.isBefore(dateTime);
    }
    return false;
  }
}
