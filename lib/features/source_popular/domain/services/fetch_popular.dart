import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

final fetchPopularProvider = Provider<FetchPopular>(
  (ref) => FetchPopular(
    getIsConnectionAvailable: ref.watch(getIsConnectionAvailableProvider),
  ),
  name: 'FetchPopularProvider',
);

class FetchPopular {
  FetchPopular({
    required GetIsConnectionAvailable getIsConnectionAvailable,
  }) : _getIsConnectionAvailable = getIsConnectionAvailable;

  final GetIsConnectionAvailable _getIsConnectionAvailable;

  Future<Either<Failure, List<PartialNovelData>>> execute(
    sources.CrawlerIsolate isolate,
    int page,
  ) async {
    if (!await _getIsConnectionAvailable.execute()) {
      return const Left(NoNetworkConnection());
    }

    final List<sources.Novel> novels;
    try {
      novels = await isolate.fetchPopular(page);
    } on DioError catch (e) {
      return Left(NetworkFailure(e.message));
    }

    final entities =
        novels.map((novel) => PartialNovelData.fromSource(novel)).toList();

    return Right(entities);
  }
}
