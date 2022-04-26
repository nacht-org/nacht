import 'package:chapturn/domain/providers/providers.dart';
import 'package:chapturn/presentation/pages/novel_page/data/novel_page_args.dart';
import 'package:chapturn/presentation/pages/novel_page/providers/loaded_controller.dart';
import 'package:chapturn/presentation/pages/novel_page/providers/novel_page_notice.dart';
import 'package:chapturn/presentation/pages/novel_page/providers/novel_page_state.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

import '../../../../domain/entities/entities.dart';
import '../data/novel_list_item.dart';
import '../data/novel_page_info.dart';

final noticeProvider =
    StateNotifierProvider<NoticeController, NovelPageNotice?>(
        (ref) => NoticeController());

final novelArgProvider =
    Provider<NovelEntityArgument>((ref) => throw UnimplementedError());

final crawlerArgProvider =
    Provider<Crawler?>((ref) => throw UnimplementedError());

final novelOverrideProvider =
    Provider<NovelEntity>((ref) => throw UnimplementedError());

final crawlerFactoryProvider = Provider<CrawlerFactory?>(
  (ref) {
    final url = ref.watch(novelArgProvider).when(
          partial: (novel) => novel.url,
          complete: (novel) => novel.url,
        );

    return ref
        .watch(getCrawlerFactoryFor)
        .execute(url)
        .fold((failure) => null, (data) => data);
  },
  dependencies: [novelArgProvider, getCrawlerFactoryFor],
);

final metaProvider = Provider<Option<Meta>>(
  (ref) {
    final factory = ref.watch(crawlerFactoryProvider);
    if (factory == null) {
      return const None();
    }

    return Some(factory.meta());
  },
  dependencies: [crawlerFactoryProvider],
);

final crawlerProvider = Provider<Crawler?>((ref) {
  final crawlerArg = ref.watch(crawlerArgProvider);
  if (crawlerArg == null) {
    return ref.watch(crawlerFactoryProvider)?.create();
  }

  return crawlerArg;
}, dependencies: [
  crawlerArgProvider,
  crawlerFactoryProvider,
]);

final novelPageState =
    StateNotifierProvider<NovelPageController, NovelPageState>(
  (ref) {
    final state = ref.watch(novelArgProvider).when(
          partial: NovelPageState.partial,
          complete: NovelPageState.loaded,
        );

    final controller = NovelPageController(
      initial: state,
      crawler: ref.watch(crawlerProvider),
      read: ref.read,
      parseOrGetNovel: ref.watch(parseOrGetNovel),
    );

    state.mapOrNull(
      partial: (value) => controller.reload(),
    );

    return controller;
  },
  dependencies: [
    novelArgProvider,
    crawlerProvider,
    noticeProvider,
    parseOrGetNovel,
    getAllCategories,
    changeNovelCategories,
  ],
);

final novelInfoProvider = Provider<NovelPageInfo>((ref) {
  final state = ref.watch(novelPageState);
  final meta = ref.watch(metaProvider);

  return state.when(
    partial: (novel) => NovelPageInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: const None(),
      meta: meta,
    ),
    loaded: (novel) => NovelPageInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: Some(novel.status),
      meta: meta,
    ),
  );
}, dependencies: [
  novelPageState,
  metaProvider,
]);

// Providers only for loaded page state.

final novelProvider = StateNotifierProvider<LoadedController, NovelEntity>(
  (ref) {
    final novel = ref.watch(novelOverrideProvider);
    final crawler = ref.watch(crawlerProvider);

    return LoadedController(
      novel,
      crawler: crawler,
      noticeController: ref.watch(noticeProvider.notifier),
      parseOrGetNovel: ref.watch(parseOrGetNovel),
      getAllCategories: ref.watch(getAllCategories),
      changeNovelCategories: ref.watch(changeNovelCategories),
    );
  },
  dependencies: [
    crawlerProvider,
    noticeProvider.notifier,
    novelOverrideProvider,
    parseOrGetNovel,
    getAllCategories,
    changeNovelCategories,
  ],
);

final novelMoreProvider = Provider<NovelPageMore>(
  (ref) {
    final novel = ref.watch(novelProvider);

    return NovelPageMore(
      description: novel.description,
      tags: novel.metadata
          .where((namespace) => namespace.name == 'subject')
          .map((namespace) => namespace.value)
          .toList(),
    );
  },
  dependencies: [novelProvider],
);

final volumesProvider = Provider<List<VolumeEntity>>(
  (ref) {
    final novel = ref.watch(novelProvider);
    return novel.volumes;
  },
  dependencies: [novelProvider],
);

final itemsProvider = Provider<List<NovelListItem>>(
  (ref) {
    final volumes = ref.watch(volumesProvider);
    final items = <NovelListItem>[];
    if (volumes.length == 1) {
      items.addAll(volumes.single.chapters.map(NovelListItem.chapter));
    } else {
      for (final volume in volumes) {
        items.add(NovelListItem.volume(volume));
        items.addAll(volume.chapters.map(NovelListItem.chapter));
      }
    }
    return items;
  },
  dependencies: [volumesProvider],
);

final chapterCountProvider = Provider<int>(
  (ref) {
    final volumes = ref.watch(volumesProvider);
    return volumes.map((e) => e.chapters.length).sum;
  },
  dependencies: [volumesProvider],
);
