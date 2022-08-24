import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

final fetchNovelProvider = Provider<FetchNovel>(
  (ref) => FetchNovel(
    isConnectionAvailable: ref.watch(getIsConnectionAvailableProvider),
    updateNovel: ref.watch(updateNovelProvider),
    addChapterUpdates: ref.watch(addChapterUpdatesProvider),
  ),
  name: 'FetchNovelProvider',
);

/// Fetch novel online and update the database
class FetchNovel {
  FetchNovel({
    required GetIsConnectionAvailable isConnectionAvailable,
    required UpdateNovel updateNovel,
    required AddChapterUpdates addChapterUpdates,
  })  : _isConnectionAvailable = isConnectionAvailable,
        _addChapterUpdates = addChapterUpdates,
        _updateNovel = updateNovel;

  final GetIsConnectionAvailable _isConnectionAvailable;
  final UpdateNovel _updateNovel;
  final AddChapterUpdates _addChapterUpdates;

  Future<Option<Failure>> execute(
    sources.CrawlerIsolate isolate,
    String url,
  ) async {
    final isConnectionAvailable = await _isConnectionAvailable.execute();
    if (!isConnectionAvailable) {
      return const Some(NoNetworkConnection());
    }

    final sources.Novel novel;
    try {
      novel = await isolate.fetchNovel(url);
    } on DioError catch (e) {
      return Some(NetworkFailure(e.message));
    }

    final updateResult = await _updateNovel.execute(novel);

    // Insert the updates values
    final insertResult = await updateResult.fold<Future<Option<Failure>>>(
      (failure) async => Some(failure),
      (data) async {
        if (!data.isInitial) {
          return await _addChapterUpdates.execute(
              data.novelId, data.insertedIds.reversed);
        }

        return const None();
      },
    );

    return insertResult;
  }
}
