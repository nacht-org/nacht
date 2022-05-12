import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';
import 'library_provider.dart';

part 'library_view_provider.freezed.dart';

final libraryViewProvider = Provider<LibraryViewData>((ref) {
  var categories = ref.watch(libraryProvider);

  if (categories.isEmpty) {
    return const LibraryViewData.empty();
  } else if (categories.length == 1) {
    final category = categories.single;
    assert(category.isDefault);

    return LibraryViewData.singular(category);
  } else {
    categories = categories
        .where((category) => !(category.isDefault && category.novels.isEmpty))
        .sorted(((a, b) => a.index.compareTo(b.index)));

    return LibraryViewData.tabular(categories);
  }
});

@freezed
class LibraryViewData with _$LibraryViewData {
  const factory LibraryViewData.tabular(List<CategoryData> categories) =
      _TabView;
  const factory LibraryViewData.singular(CategoryData category) = _SingularView;
  const factory LibraryViewData.empty() = _EmptyView;
}
