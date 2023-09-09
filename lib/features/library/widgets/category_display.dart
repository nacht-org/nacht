import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

import '../preferences/preferences.dart';
import 'widgets.dart';

class CategoryDisplay extends ConsumerWidget {
  const CategoryDisplay({
    super.key,
    required this.category,
  });

  final CategoryData category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayMode = ref.watch(
        libraryDisplayPreferencesProvider.select((value) => value.displayMode));

    return switch (displayMode) {
      LibraryDisplayMode.compactGrid => CategoryGrid(category: category),
      LibraryDisplayMode.list => CategoryList(category: category),
    };
  }
}
