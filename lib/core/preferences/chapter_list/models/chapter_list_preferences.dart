import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import '../chapter_list.dart';

part 'chapter_list_preferences.freezed.dart';

@freezed
class ChapterListPreferences with _$ChapterListPreferences {
  factory ChapterListPreferences({
    required SortPreference sort,
    required OrderPreference order,
  }) = _ChapterListPreferences;

  static const orderKey =
      EnumPreferenceKey("order", parse: OrderPreference.parse);
  static const sortKey = EnumPreferenceKey("sort", parse: SortPreference.parse);

  factory ChapterListPreferences.read(Preferences preferences) {
    return ChapterListPreferences(
      order: orderKey.getValue(preferences, OrderPreference.descending),
      sort: sortKey.getValue(preferences, SortPreference.source),
    );
  }

  ChapterListPreferences._();
}
