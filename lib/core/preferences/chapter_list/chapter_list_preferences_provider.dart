import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/preferences/chapter_list/chapter_list.dart';
import 'package:nacht/core/preferences/preferences_provider.dart';
import 'package:nacht/nht/nht.dart';

final chapterListPreferencesProvider = StateNotifierProvider<
    ChapterListPreferencesNotifier, ChapterListPreferences>((ref) {
  return ChapterListPreferencesNotifier(
    preferences: ref.watch(preferencesProvider("chapter-list")),
  );
});

class ChapterListPreferencesNotifier
    extends StateNotifier<ChapterListPreferences> {
  ChapterListPreferencesNotifier({
    required Preferences preferences,
  })  : _preferences = preferences,
        super(ChapterListPreferences.read(preferences));

  final Preferences _preferences;

  void setOrder(OrderPreference order) {
    state = state.copyWith(order: order);
    ChapterListPreferences.orderKey.setValue(_preferences, order);
  }

  void setSort(SortPreference sort) {
    state = state.copyWith(sort: sort);
    ChapterListPreferences.sortKey.setValue(_preferences, sort);
  }
}
