import 'package:chapturn/components/novel/model/essential_info.dart';
import 'package:chapturn/components/novel/provider/intermediate_provider.dart';
import 'package:chapturn/components/novel/widgets/info.dart';
import 'package:dartz/dartz.dart';
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

    return Scaffold(
      body: state.when(
        partial: (novel, meta, crawler) {
          final info = EssentialInfo.fromPartial(novel).copyWith(
            meta: meta == null ? const None() : Some(meta),
          );

          return ProviderScope(
            overrides: [
              currentEssentialProvider.overrideWithValue(info),
            ],
            child: PartialView(either: either, novel: novel),
          );
        },
        complete: (novel, meta, crawler) {
          final info = EssentialInfo.fromNovel(novel).copyWith(
            meta: meta == null ? const None() : Some(meta),
          );

          return ProviderScope(
            overrides: [
              currentEssentialProvider.overrideWithValue(info),
            ],
            child: NovelView(
              data: novel,
              crawler: crawler,
              load: either.maybeMap(complete: (_) => true, orElse: () => false),
            ),
          );
        },
      ),
    );
  }
}
