import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/novel/services/updatable_novels.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

final refreshNovelsProvider = Provider<RefreshNovels>((ref) {
  final refresh = RefreshNovels(
    crawlerFactoryByUrl: ref.watch(crawlerFactoryByUrlProvider),
    updatableNovels: ref.watch(updatableNovelsProvider),
    fetchNovel: ref.watch(fetchNovelProvider),
  );
  return refresh;
});

class RefreshNovels with LoggerMixin {
  RefreshNovels({
    required CrawlerFactoryByUrl crawlerFactoryByUrl,
    required UpdatableNovels updatableNovels,
    required FetchNovel fetchNovel,
  })  : _crawlerFactoryByUrl = crawlerFactoryByUrl,
        _updatableNovels = updatableNovels,
        _fetchNovel = fetchNovel;

  final CrawlerFactoryByUrl _crawlerFactoryByUrl;
  final FetchNovel _fetchNovel;
  final UpdatableNovels _updatableNovels;

  Future<Map<NovelData, Failure>> execute() async {
    final isolates = <sources.Meta, sources.CrawlerIsolate>{};
    final failures = <NovelData, Failure>{};

    log.finer("Commencing novels refresh.");

    try {
      final novels = await _updatableNovels.execute();
      log.fine("Retrieved ${novels.length} updatable novels.");

      for (final novel in novels) {
        log.fine("Attempting to update ${novel.id}: ${novel.title}.");
        final failure = await _run(novel, isolates);
        if (failure != null) {
          log.fine(
              "Recording failed novel update for ${novel.id}: ${novel.title} with $failure");
          failures[novel] = failure;
        }
      }
    } finally {
      log.fine("Closing ${isolates.length} isolates after refresh updates.");
      for (final isolate in isolates.values) {
        isolate.close();
      }
    }

    return failures;
  }

  Future<Failure?> _run(
    NovelData novel,
    Map<sources.Meta, sources.CrawlerIsolate> isolates,
  ) async {
    final factory = _crawlerFactoryByUrl.execute(novel.url);
    if (factory == null) {
      log.warning("No crawler supported for ${novel.url}");
      return CrawlerNotFound("No crawler supported for ${novel.url}");
    }

    log.fine("Retrieved factory for ${novel.id}: ${novel.title}");

    final isolate = isolates.putIfAbsent(
      factory.meta(),
      () => sources.CrawlerIsolate(factory: factory),
    );

    final result = await _fetchNovel.execute(isolate, novel.url);
    return result.toNullable();
  }
}
