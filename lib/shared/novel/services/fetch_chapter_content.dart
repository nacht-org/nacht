import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:nacht/shared/shared.dart';

final fetchChapterContentProvider = Provider<FetchChapterContent>(
  (ref) => FetchChapterContent(
    isConnectionAvailable: ref.watch(getIsConnectionAvailableProvider),
  ),
  name: "FetchChapterContentProvider",
);

class FetchChapterContent {
  FetchChapterContent({
    required GetIsConnectionAvailable isConnectionAvailable,
  }) : _isConnectionAvailable = isConnectionAvailable;

  final GetIsConnectionAvailable _isConnectionAvailable;

  Future<Either<Failure, String>> execute(
    sources.CrawlerIsolate isolate,
    String url,
  ) async {
    final isConnectionAvailable = await _isConnectionAvailable.execute();
    if (!isConnectionAvailable) {
      return const Left(NoNetworkConnection());
    }

    try {
      final content = await isolate.fetchChapterContent(url);
      return Right(content!);
    } on DioError catch (e) {
      return Left(NetworkFailure(e.message ?? "Unknown error"));
    }
  }
}
