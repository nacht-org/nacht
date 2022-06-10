import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nacht/core/preferences/date_format/date_format_prefernces_provider.dart';

final dateFormatFamily = Provider.autoDispose.family<DateFormat, Locale>(
  (ref, locale) {
    final dateFormatPattern = ref.watch(dateFormatPreferencesProvider
        .select((preferences) => preferences.pattern));

    // FIXME: LocaleDataException (LocaleDataException: Locale data has not been initialized, call initializeDateFormatting(<locale>).)
    return DateFormat(dateFormatPattern.pattern);
  },
  name: 'DateFormatFamily',
);
