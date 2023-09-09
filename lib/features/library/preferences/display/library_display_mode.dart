import 'package:nacht/nht/core/preferences/preference_key.dart';

enum LibraryDisplayMode implements EnumPreference {
  compactGrid(1, "Compact grid", LibraryDisplayModeType.grid),
  list(2, "List", LibraryDisplayModeType.list);

  const LibraryDisplayMode(this.id, this.label, this.type);

  @override
  final int id;
  final String label;
  final LibraryDisplayModeType type;

  factory LibraryDisplayMode.parse(int id) {
    final displayMode = LibraryDisplayMode.values
        .where((element) => element.id == id)
        .firstOrNull;
    if (displayMode == null) {
      throw Exception("error parsing library.display.display-mode");
    }
    return displayMode;
  }
}

enum LibraryDisplayModeType {
  grid,
  list,
}
