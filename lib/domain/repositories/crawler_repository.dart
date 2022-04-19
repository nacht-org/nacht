import 'package:chapturn/core/failure.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract class CrawlerRepository {
  Either<Failure, CrawlerFactory> crawlerFactoryFor(String url);
  Either<Failure, List<CrawlerFactory>> getAllCrawlers();
  Future<Either<Failure, List<PartialNovelEntity>>> getPopularNovels(
      NovelPopular parser);
}
