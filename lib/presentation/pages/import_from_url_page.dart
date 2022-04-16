import 'package:chapturn/presentation/controllers/import_from_url/search_result_provider.dart';
import 'package:chapturn/presentation/controllers/import_from_url/searchbar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImportFromUrlPage extends StatelessWidget {
  const ImportFromUrlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ImportFromUrlAppBar(),
      body: Consumer(builder: (context, ref, child) {
        final result = ref.watch(importFromUrlResult);

        return result.when(
          empty: () => Container(),
          found: (crawlerFactory) => Center(
            child: Text(crawlerFactory.meta().name),
          ),
          notFound: () => Center(child: Text('Not found')),
          error: (reason) => Center(
            child: Text(reason),
          ),
        );
      }),
    );
  }
}

class ImportFromUrlAppBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  const ImportFromUrlAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    ref.listen<String>(importUrlSearchBarProvider, (previous, next) {
      if (controller.text != next) {
        controller.text = next;
      }
    });

    final text = ref.watch(importUrlSearchBarProvider);

    return AppBar(
      title: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Import from url',
          border: InputBorder.none,
        ),
        onChanged: ref.watch(importUrlSearchBarProvider.notifier).change,
      ),
      actions: [
        if (text.isEmpty)
          IconButton(
            onPressed: ref.watch(importUrlSearchBarProvider.notifier).paste,
            icon: const Icon(Icons.paste),
            tooltip: 'Paste',
          ),
        if (text.isNotEmpty)
          IconButton(
            onPressed: ref.watch(importUrlSearchBarProvider.notifier).clear,
            icon: const Icon(Icons.clear),
            tooltip: 'Clear',
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
