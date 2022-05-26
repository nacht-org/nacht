import 'package:nacht/components/novel/model/head_info.dart';
import 'package:nacht/components/novel/provider/intermediate_provider.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/novel_either.dart';
import 'widgets/novel_view.dart';
import 'widgets/partial_view.dart';

export 'model/novel_either.dart';

class NovelPage extends ConsumerWidget {
  const NovelPage({
    Key? key,
    required this.either,
  }) : super(key: key);

  final NovelEither either;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intermediateProvider(either));

    return state.when(
      partial: (novel, meta, crawler) {
        return PartialView(
          either: either,
          novel: novel,
          head: HeadInfo.fromPartial(novel, meta),
        );
      },
      complete: (novel, meta, crawler) {
        return NovelView(
          data: novel,
          crawler: crawler,
          head: HeadInfo.fromNovel(novel, meta),
          load: either.maybeMap(complete: (_) => true, orElse: () => false),
        );
      },
    );
  }
}
