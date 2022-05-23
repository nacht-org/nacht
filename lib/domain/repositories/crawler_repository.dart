import 'package:chapturn/core/failure.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

final crawlerRepositoryProvider = Provider<CrawlerRepository>(
  (ref) => CrawlerRepositoryImpl(),
  name: 'CrawlerRepositoryProvider',
);

abstract class CrawlerRepository {
  Option<CrawlerFactory> crawlerFactoryFor(String url);
  Either<Failure, List<CrawlerFactory>> getAllCrawlers();

  Future<Either<Failure, List<PartialNovelData>>> getPopularNovels(
    ParsePopular parser,
    int page,
  );

  Future<Either<Failure, List<PartialNovelData>>> getSearchNovels(
    ParseSearch parser,
    String query,
    int page,
  );
}
