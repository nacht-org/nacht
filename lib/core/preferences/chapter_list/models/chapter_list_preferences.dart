import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/core/preferences/chapter_list/models/order_preference.dart';
import 'package:nacht/nht/nht.dart';

part 'chapter_list_preferences.freezed.dart';

@freezed
class ChapterListPreferences with _$ChapterListPreferences {
  factory ChapterListPreferences({
    required OrderPreference order,
  }) = _ChapterListPreferences;

  static const orderKey =
      EnumPreferenceKey("order", parse: OrderPreference.parse);

  factory ChapterListPreferences.read(Preferences preferences) {
    return ChapterListPreferences(
      order: orderKey.getValue(preferences, OrderPreference.descending),
    );
  }

  ChapterListPreferences._();
}
