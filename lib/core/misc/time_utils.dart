extension ParseRelativeDay on DateTime {
  int _difference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  T relative<T>({
    required int cutoff,
    required T Function(DateTime dateTime) precise,
    required T Function() yesterday,
    required T Function() today,
    required T Function() tomorrow,
    required T Function(int count) daysFrom,
    required T Function(int count) daysAgo,
  }) {
    final diff = _difference(this);
    if (diff.abs() > cutoff) {
      return precise(this);
    } else if (diff == -1) {
      return yesterday();
    } else if (diff == 0) {
      return today();
    } else if (diff == 1) {
      return tomorrow();
    } else if (diff > 0) {
      return daysFrom(diff);
    } else {
      return daysAgo(diff.abs());
    }
  }
}
