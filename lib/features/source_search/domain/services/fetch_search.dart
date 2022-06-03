import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/domain/domain.dart';
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
    sources.ParseSearch parser,
    String query,
    int page,
  ) async {
    if (!await _getIsConnectionAvailable.execute()) {
      return const Left(NetworkFailure("Connection not available"));
    }

    final List<sources.Novel> novels;
    try {
      novels = await parser.search(query, page);
    } on DioError catch (e) {
      return Left(NetworkFailure(e.message));
    }

    final entities = novels.map(PartialNovelData.fromSource).toList();

    return Right(entities);
  }
}
