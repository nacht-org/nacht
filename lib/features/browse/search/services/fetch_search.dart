import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

final fetchSearchProvider = Provider<FetchSearch>(
  (ref) => FetchSearch(
    getIsConnectionAvailable: ref.watch(getIsConnectionAvailableProvider),
  ),
  name: 'FetchSearchProvider',
);

class FetchSearch {
  FetchSearch({
    required GetIsConnectionAvailable getIsConnectionAvailable,
  }) : _getIsConnectionAvailable = getIsConnectionAvailable;

  final GetIsConnectionAvailable _getIsConnectionAvailable;

  Future<Either<Failure, List<PartialNovelData>>> execute(
    sources.CrawlerIsolate isolate,
    String query,
    int page,
  ) async {
    if (!await _getIsConnectionAvailable.execute()) {
      return const Left(NoNetworkConnection());
    }

    final List<sources.Novel> novels;
    try {
      novels = await isolate.fetchSearch(query, page);
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? "Unknown failure"));
    }

    final entities = novels.map(PartialNovelData.fromSource).toList();

    return Right(entities);
  }
}
