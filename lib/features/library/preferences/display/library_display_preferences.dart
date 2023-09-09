import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/nht/nht.dart';

import 'library_display_mode.dart';

part 'library_display_preferences.freezed.dart';

@freezed
class LibraryDisplayPreferencs with _$LibraryDisplayPreferencs {
  const factory LibraryDisplayPreferencs({
    required LibraryDisplayMode displayMode,
  }) = _LibraryDisplayPreferencs;

  static const displayModeKey =
      EnumPreferenceKey('display-mode', parse: LibraryDisplayMode.parse);

  factory LibraryDisplayPreferencs.read(Preferences preferences) {
    return LibraryDisplayPreferencs(
      displayMode:
          displayModeKey.getValue(preferences, LibraryDisplayMode.compactGrid),
    );
  }

  const LibraryDisplayPreferencs._();
}
