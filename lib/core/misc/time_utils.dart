import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math' as math;

part 'time_utils.freezed.dart';

@freezed
class RelativeDay with _$RelativeDay {
  const factory RelativeDay.yesterday() = _RelativeYesterday;
  const factory RelativeDay.today() = _RelativeToday;
  const factory RelativeDay.tomorrow() = _RelativeTomorrow;
  factory RelativeDay.daysAgo(int count) = _RelativeAgo;
  factory RelativeDay.daysFrom(int count) = _RelativeFrom;
  factory RelativeDay.precise(DateTime dateTime) = _RelativePrecise;

  const RelativeDay._();
}

extension ParseRelativeDay on DateTime {
  int _difference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  RelativeDay get relativeDay {
    final diff = _difference(this);
    if (diff.abs() > 7) {
      return RelativeDay.precise(this);
    } else if (diff == -1) {
      return const RelativeDay.yesterday();
    } else if (diff == 0) {
      return const RelativeDay.today();
    } else if (diff == 1) {
      return const RelativeDay.tomorrow();
    } else if (diff > 0) {
      return RelativeDay.daysFrom(diff);
    } else {
      return RelativeDay.daysAgo(diff.abs());
    }
  }
}
