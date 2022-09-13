import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nacht/core/core.dart';

final dateFormatServiceFamily =
    Provider.autoDispose.family<DateFormatService, Locale>(
  (ref, locale) => DateFormatService(
    dateFormat: ref.watch(dateFormatFamily(locale)),
    relative: ref.watch(
      dateFormatPreferencesProvider.select((value) => value.relative),
    ),
  ),
  name: 'DateFormatServiceFamily',
);

class DateFormatService {
  DateFormatService({
    required DateFormat dateFormat,
    required RelativeTimestamp relative,
  })  : _dateFormat = dateFormat,
        _relative = relative;

  final DateFormat _dateFormat;
  final RelativeTimestamp _relative;

  String relativeDay(DateTime date) {
    if (_relative == RelativeTimestamp.disabled) {
      return formatDate(date);
    }

    return date.relative(
      cutoff: cutoff,
      yesterday: () => 'Yesterday',
      today: () => 'Today',
      tomorrow: () => 'Tomorrow',
      daysAgo: (count) => '$count days ago',
      daysFrom: (count) => '$count days to go',
      precise: (date) => formatDate(date),
    );
  }

  String formatDate(DateTime date) => _dateFormat.format(date);

  /// The cutoff point from where precise formatting is used
  late final int cutoff = _cutoff();

  int _cutoff() {
    switch (_relative) {
      case RelativeTimestamp.disabled:
        return -1;
      case RelativeTimestamp.short:
        return 1;
      case RelativeTimestamp.long:
        return 7;
    }
  }
}
