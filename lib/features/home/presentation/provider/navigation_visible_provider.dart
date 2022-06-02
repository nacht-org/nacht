import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/components.dart';

final navigationVisibleProvider = Provider<bool>((ref) {
  final browseSearchActive =
      ref.watch(browseSearchProvider.select((search) => search.active));

  if ([browseSearchActive].any((element) => element)) {
    return false;
  }

  return true;
});
