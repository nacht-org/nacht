import 'package:nacht/nht/nht.dart';

enum BrowseDisplayMode implements EnumPreference {
  compactGrid(1, "Compact grid"),
  list(2, "List");

  const BrowseDisplayMode(this.id, this.label);

  @override
  final int id;
  final String label;

  factory BrowseDisplayMode.parse(int id) {
    final displayMode = BrowseDisplayMode.values
        .where((element) => element.id == id)
        .firstOrNull;
    if (displayMode == null) {
      throw Exception("error parsing library.display.display-mode");
    }
    return displayMode;
  }
}
