import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../services/services.dart';
import 'providers.dart';

final downloadRunnerProvider =
    StateNotifierProvider<DownloadRunnerNotifier, void>(
  (ref) {
    final notifier = DownloadRunnerNotifier(
      ref: ref,
      downloadChapter: ref.watch(downloadChapterProvider),
    );

    ref.listen<bool>(
      downloadProvider.select((state) => state.isRunning),
      (previous, next) {
        if (next) {
          notifier.start();
        }
      },
    );

    return notifier;
  },
  name: 'DownloadrunnerProvider',
);

class DownloadRunnerNotifier extends StateNotifier<void> with LoggerMixin {
  DownloadRunnerNotifier({
    required Ref ref,
    required DownloadChapter downloadChapter,
  })  : _ref = ref,
        _downloadChapter = downloadChapter,
        super(null);

  final Ref _ref;
  final DownloadChapter _downloadChapter;

  DownloadState get download => _ref.read(downloadProvider);
  DownloadNotifier get downloadNotifier => _ref.read(downloadProvider.notifier);

  DownloadListState get downloadList => _ref.read(downloadListProvider);
  DownloadListNotifier get downloadListNotifier =>
      _ref.read(downloadListProvider.notifier);

  Future<void> start() async {
    log.info("Download starting");

    try {
      while (download.isRunning) {
        final success = await _download();
        if (!success) break;
      }
    } finally {
      downloadNotifier.stop();
    }
  }

  Future<bool> _download() async {
    final data = downloadList.first;
    if (data == null) {
      log.warning("Download stopped: Unable to obtain download");
      return false;
    }

    log.info(
        'Downloading ${data.id} => ${data.related.chapterId} ${data.related.chapterTitle}');

    final factory = _ref.read(crawlerFactoryFamily(data.related.novelUrl));
    if (factory == null) {
      log.warning(
          "Download stopped: Unable to obtain source for novel '${data.related.novelUrl}' and chapter '${data.related.chapterUrl}'");
      _ref
          .read(messageServiceProvider)
          .showText("Could not find crawler for ${data.related.chapterTitle}.");
      return false;
    }

    final meta = factory.meta();
    final handler = sources.CrawlerIsolate(factory: factory);

    final Either<Failure, AssetData> result;
    try {
      downloadNotifier.setCurrent(data);
      result = await _downloadChapter.call(
        meta,
        handler,
        data.related.novelId,
        data.related.chapterId,
        data.related.chapterUrl,
      );
    } finally {
      handler.close();
    }

    await result.fold(
      (failure) {
        log.warning(failure);
        _ref.read(messageServiceProvider).showText(failure.message);
      },
      (asset) async {
        downloadNotifier.setCurrent(null);
        await downloadListNotifier.remove(data.id);
        log.info(
          "Chapter download successful: ${data.related.chapterId} ${data.related.chapterTitle}",
        );
      },
    );

    if (result.isLeft()) {
      log.warning("Stopping download after failure");
      return false;
    }

    return true;
  }
}
