import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

import '../presentation.dart';

class NovelPage extends ConsumerWidget {
  const NovelPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final NovelType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return type.when(
      partial: (novel) {
        return Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(intermediateProvider(novel));
            return state.when(
              partial: (novel, failure) => PartialView(novel: novel),
              complete: buildNovelView,
            );
          },
        );
      },
      complete: (novel) => buildNovelView(novel),
    );
  }

  NovelView buildNovelView(NovelData novel) {
    return NovelView(
      data: novel,
      load: type.maybeMap(complete: (_) => true, orElse: () => false),
    );
  }
}
