import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nacht/core/core.dart';

final dateFormatServiceFamily =
    Provider.autoDispose.family<DateFormatService, Locale>(
  (ref, locale) => DateFormatService(
    dateFormat: ref.watch(dateFormatFamily(locale)),
  ),
  name: 'DateFormatServiceFamily',
);

class DateFormatService {
  DateFormatService({
    required DateFormat dateFormat,
  }) : _dateFormat = dateFormat;

  final DateFormat _dateFormat;

  String relativeDay(DateTime date) {
    return date.relativeDay.when(
      yesterday: () => 'Yesterday',
      today: () => 'Today',
      tomorrow: () => 'Tomorrow',
      daysAgo: (count) => '$count days ago',
      daysFrom: (count) => '$count days to go',
      precise: (date) => formatDate(date),
    );
  }

  String formatDate(DateTime date) => _dateFormat.format(date);
}
