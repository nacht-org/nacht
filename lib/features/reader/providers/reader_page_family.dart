import 'package:fpdart/fpdart.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

final readerPageFamily = StateNotifierProvider.autoDispose
    .family<ReaderPageNotifier, ReaderPageInfo, ReaderPageInfo>(
  (ref, info) => ReaderPageNotifier(
    state: info,
    fetchChapterContent: ref.watch(fetchChapterContentProvider),
    getAsset: ref.watch(getAssetProvider),
    readAssetAsString: ref.watch(readAssetAsStringProvider),
  ),
  name: 'ReaderPageProvider',
);

class ReaderPageNotifier extends StateNotifier<ReaderPageInfo>
    with LoggerMixin {
  ReaderPageNotifier({
    required ReaderPageInfo state,
    required FetchChapterContent fetchChapterContent,
    required GetAsset getAsset,
    required ReadAssetAsString readAssetAsString,
  })  : _fetchChapterContent = fetchChapterContent,
        _getAsset = getAsset,
        _readAssetAsString = readAssetAsString,
        super(state);

  final FetchChapterContent _fetchChapterContent;
  final GetAsset _getAsset;
  final ReadAssetAsString _readAssetAsString;

  Future<void> reload(CrawlerInfo? crawler) async {
    if (state.fetched) {
      log.warning('chapter content already fetched.');
    }

    // Make sure loading screen is being shown.
    state = state.copyWith(content: const ContentInfo.loading());

    final diskResult = await readFromDisk();

    // The provider may be dismounted before read ends.
    if (!mounted) return;

    final diskFailure = diskResult.fold((f) => f, (r) => null);
    final diskContent = diskResult.fold((f) => null, (r) => r);

    if (diskContent != null) {
      state = state.copyWith(
        content: ContentInfo.data(diskContent),
        fetched: true,
      );
      return;
    }

    final fetchResult = await fetchFromWeb(crawler);

    // The provider may be dismounted before fetch ends.
    if (!mounted) return;

    fetchResult.fold(
      (failure) {
        final message = [
          if (diskFailure != null) diskFailure.message,
          failure.message
        ].join('\n');

        log.warning(message);
        state = state.copyWith(content: ContentInfo.error(message));
        return null;
      },
      (content) {
        state = state.copyWith(
          content: ContentInfo.data(content),
          fetched: true,
        );
      },
    );
  }

  Future<Either<Failure, String>> fetchFromWeb(CrawlerInfo? crawler) async {
    // TODO: check for crawler support
    return await _fetchChapterContent.execute(
        crawler!.isolate, state.chapter.url);
  }

  Future<Either<Failure, String?>> readFromDisk() async {
    if (state.chapter.content == null) {
      return const Right(null);
    }

    final asset = await _getAsset.call(state.chapter.content!);
    if (asset == null) {
      return const Right(null);
    }

    return await _readAssetAsString.call(asset);
  }
}
