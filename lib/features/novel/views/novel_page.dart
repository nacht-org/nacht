import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

@RoutePage()
class NovelPage extends ConsumerWidget {
  const NovelPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final NovelType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intermediateProvider(type));

    return state.novel.when(
      url: (url) => LoadingView(
        type: type,
        error: state.error,
      ),
      partial: (partial) => PartialView(
        type: type,
        novel: partial,
        error: state.error,
      ),
      novel: (novel) => NovelView(
        data: novel,
        direct: type.maybeMap(
          novel: (_) => true,
          orElse: () => false,
        ),
      ),
    );
  }
}

class LoadingView extends HookConsumerWidget {
  const LoadingView({
    Key? key,
    required this.type,
    required this.error,
  }) : super(key: key);

  final NovelType type;
  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactory = ref.watch(crawlerFactoryFamily(type.url));
    final crawler = crawlerFactory != null
        ? ref.watch(crawlerFamily(crawlerFactory))
        : null;

    final notifier = ref.watch(intermediateProvider(type).notifier);

    usePostFrameCallback((timeStamp) {
      notifier.fetch(crawler);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(crawler?.meta.name ?? ''),
      ),
      body: error == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LoadingError(
              message: Text(error!),
              onRetry: () => notifier.fetch(crawler),
            ),
    );
  }
}
