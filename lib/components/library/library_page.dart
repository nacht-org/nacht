import 'package:chapturn/components/library/provider/library_view_provider.dart';
import 'package:chapturn/components/library/provider/library_provider.dart';
import 'package:chapturn/components/library/widgets/singular_library_display.dart';
import 'package:chapturn/components/library/widgets/tabular_library_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LibraryPage extends HookConsumerWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(libraryViewProvider);
    final notifier = ref.watch(libraryProvider.notifier);

    useEffect(() {
      notifier.reload();
      return null;
    }, []);

    return view.map(
      singular: (state) => SingularLibraryDisplay(category: state.category),
      tabular: (state) => TabularLibraryDisplay(categories: state.categories),
    );
  }
}
