import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/widgets/widgets.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class PartialView extends HookWidget {
  const PartialView({
    Key? key,
    required this.type,
    required this.novel,
    required this.error,
  }) : super(key: key);

  final NovelType type;
  final PartialNovelData novel;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final refreshKey = useRefresh();

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(novel.title),
            floating: true,
            forceElevated: innerBoxIsScrolled,
          )
        ],
        body: Consumer(
          builder: (context, ref, child) {
            final notifier = ref.watch(intermediateProvider(type).notifier);
            final crawlerFactory = ref.watch(crawlerFactoryFamily(novel.url));
            final crawler = crawlerFactory != null
                ? ref.watch(crawlerFamily(crawlerFactory))
                : null;

            return RefreshIndicator(
              onRefresh: () => notifier.fetch(crawler),
              key: refreshKey,
              child: child!,
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 24.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                sliver: NovelHead(
                  head: HeadInfo.fromPartial(novel),
                ),
              ),
              if (error != null)
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(
                    child: LoadingError(
                      message: Text(error!),
                      onRetry: () => refreshKey.currentState!.show(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
