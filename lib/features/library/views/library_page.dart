import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/library_view_provider.dart';
import '../widgets/singular_library_display.dart';
import '../widgets/tabular_library_display.dart';

class LibraryPage extends HookConsumerWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(libraryViewProvider);

    return view.map(
      singular: (state) => SingularLibraryDisplay(category: state.category),
      tabular: (state) => TabularLibraryDisplay(categories: state.categories),
    );
  }
}
