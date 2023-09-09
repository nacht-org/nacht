import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';

class CategoryLoader extends ConsumerWidget {
  const CategoryLoader({
    Key? key,
    required this.category,
    required this.builder,
  }) : super(key: key);

  final CategoryData category;
  final Widget Function(BuildContext context, List<NovelData> novels) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryNovelsFamily(category.id));

    return state.when(
      loading: () {
        return const SizedBox.shrink();
      },
      error: (error, stack) {
        return CenterChildScrollView(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: LoadingError(
            message: Text(error.toString()),
          ),
        );
      },
      data: (data) {
        if (data.isEmpty) {
          return buildEmptyIndicator(ref);
        }

        return builder(context, data);
      },
    );
  }

  CenterChildScrollView buildEmptyIndicator(WidgetRef ref) {
    final actions = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () => ref
              .read(homeIndexProvider.notifier)
              .setDestination(Destinations.browse),
          icon: const Icon(Icons.explore),
          label: const Text('Browse'),
        ),
      ],
    );

    return CenterChildScrollView(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: EmptyIndicator(
        icon: const Icon(Icons.category),
        label: const Text('Category is empty'),
        child: category.isDefault ? actions : null,
      ),
    );
  }
}
