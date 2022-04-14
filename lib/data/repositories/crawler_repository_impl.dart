import 'package:chapturn/data/failure.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

class CrawlerRepositoryImpl implements CrawlerRepository {
  @override
  Future<Either<Failure, CrawlerFactory>> crawlerFactoryFor(String url) async {
    final crawler = sources.crawlerFactoryFor(url);
    if (crawler == null) {
      return const Left(CrawlerFactoryNotFoundFailure());
    } else {
      return Right(crawler);
    }
  }

  @override
  Either<Failure, List<CrawlerFactory>> getAllCrawlers() {
    return const Right(crawlers);
  }
}
