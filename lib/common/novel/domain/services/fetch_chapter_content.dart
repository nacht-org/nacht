import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/network/domain/domain.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

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
      sources.ParseNovel parser, String url) async {
    final isConnectionAvailable = await _isConnectionAvailable.execute();
    if (!isConnectionAvailable) {
      return const Left(ConnectionNotAvailable());
    }

    try {
      final chapter = sources.Chapter.withUrl(url);
      await parser.parseChapter(chapter);
      return Right(chapter.content!);
    } on DioError catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
