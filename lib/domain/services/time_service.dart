import 'package:chapturn/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final timeServiceProvider = Provider<TimeService>(
  (ref) => TimeService(),
  name: 'TimeServiceProvider',
);

class TimeService {
  final DateFormat _dateFormat = DateFormat.yMd();

  String formatChapterUpdated(DateTime dateTime) {
    return relativeDay(dateTime);
  }

  String relativeDay(DateTime dateTime) {
    return dateTime.relativeDay.when(
      yesterday: () => 'Yesterday',
      today: () => 'Today',
      tomorrow: () => 'Tomorrow',
      daysAgo: (count) => '$count days ago',
      daysFrom: (count) => '$count days to go',
      precise: (date) => formatDate(date),
    );
  }

  String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }
}
