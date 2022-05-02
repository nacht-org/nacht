import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/providers/providers.dart';
import '../../home/provider/library_provider.dart';
import '../model/novel_list_item.dart';
import '../model/novel_page_args.dart';
import '../model/novel_page_info.dart';
import 'loaded_controller.dart';
import 'novel_page_notice.dart';
import 'novel_page_state.dart';

final noticeProvider =
    StateNotifierProvider<NoticeController, NovelPageNotice?>(
        (ref) => NoticeController());

final novelArgProvider = Provider.autoDispose<NovelEntityArgument>(
    (ref) => throw UnimplementedError());

final crawlerArgProvider =
    Provider.autoDispose<Crawler?>((ref) => throw UnimplementedError());

final novelOverrideProvider =
    Provider.autoDispose<NovelEntity>((ref) => throw UnimplementedError());

final crawlerFactoryProvider = Provider.autoDispose<CrawlerFactory?>(
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

final metaProvider = Provider.autoDispose<Option<Meta>>(
  (ref) {
    final factory = ref.watch(crawlerFactoryProvider);
    if (factory == null) {
      return const None();
    }

    return Some(factory.meta());
  },
  dependencies: [crawlerFactoryProvider],
);

final crawlerProvider = Provider.autoDispose<Crawler?>((ref) {
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
    StateNotifierProvider.autoDispose<NovelPageController, NovelPageState>(
  (ref) {
    final state = ref.watch(novelArgProvider).when(
          partial: NovelPageState.partial,
          complete: NovelPageState.loaded,
        );

    return NovelPageController(
      initial: state,
      crawler: ref.watch(crawlerProvider),
      read: ref.read,
      parseOrGetNovel: ref.watch(parseOrGetNovel),
      downloadNovelCover: ref.watch(downloadNovelCover),
    );
  },
  dependencies: [
    novelArgProvider,
    crawlerProvider,
    noticeProvider.notifier,
    parseOrGetNovel,
    downloadNovelCover,
    getAllCategories,
    changeNovelCategories,
  ],
);

final novelInfoProvider = Provider.autoDispose<NovelPageInfo>((ref) {
  final state = ref.watch(novelPageState);
  final meta = ref.watch(metaProvider);

  return state.when(
    partial: (novel) => NovelPageInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      cover: const None(),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: NovelStatus.unknown,
      meta: meta,
    ),
    loaded: (novel) => NovelPageInfo(
      title: novel.title,
      coverUrl: novel.coverUrl == null ? const None() : Some(novel.coverUrl!),
      cover: novel.cover == null ? const None() : Some(novel.cover!),
      author: novel.author == null ? const None() : Some(novel.author!),
      status: novel.status,
      meta: meta,
    ),
  );
}, dependencies: [
  novelPageState,
  metaProvider,
]);

// Providers only for loaded page state.

final novelProvider =
    StateNotifierProvider.autoDispose<LoadedController, NovelEntity>(
  (ref) {
    final novel = ref.watch(novelOverrideProvider);
    final crawler = ref.watch(crawlerProvider);

    return LoadedController(
      novel,
      crawler: crawler,
      read: ref.read,
      getNovel: ref.watch(getNovel),
      parseOrGetNovel: ref.watch(parseOrGetNovel),
      downloadNovelCover: ref.watch(downloadNovelCover),
      getAllCategories: ref.watch(getAllCategories),
      changeNovelCategories: ref.watch(changeNovelCategories),
    );
  },
  dependencies: [
    novelArgProvider,
    crawlerProvider,
    noticeProvider.notifier,
    libraryProvider.notifier,
    novelOverrideProvider,
    getNovel,
    parseOrGetNovel,
    downloadNovelCover,
    getAllCategories,
    changeNovelCategories,
  ],
);

final novelMoreProvider = Provider.autoDispose<NovelPageMore>(
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

final volumesProvider = Provider.autoDispose<List<VolumeEntity>>(
  (ref) {
    final novel = ref.watch(novelProvider);
    return novel.volumes;
  },
  dependencies: [novelProvider],
);

final itemsProvider = Provider.autoDispose<List<NovelListItem>>(
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

final chapterCountProvider = Provider.autoDispose<int>(
  (ref) {
    final volumes = ref.watch(volumesProvider);
    return volumes.map((e) => e.chapters.length).sum;
  },
  dependencies: [volumesProvider],
);
