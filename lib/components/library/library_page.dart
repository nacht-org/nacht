import 'package:chapturn/components/library/widgets/category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider/library_provider.dart';
import 'provider/relevant_categories_provider.dart';
import 'widgets/library_app_bar.dart';
import 'widgets/library_tab_provider.dart';

class LibraryPage extends HookConsumerWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(libraryProvider.notifier).reload();
      return null;
    }, []);

    return TabControllerProvider(
      length: tabCountProvider,
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          LibraryAppBar(forceElevated: innerBoxIsScrolled),
        ],
        body: Consumer(
          builder: (context, ref, child) {
            final categories = ref.watch(relevantCategoriesProvider);

            if (categories.isEmpty) {
              return Container();
            } else if (categories.length == 1) {
              return CategoryView(category: categories.single);
            } else {
              return TabBarView(
                children: categories
                    .map((category) => CategoryView(category: category))
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
