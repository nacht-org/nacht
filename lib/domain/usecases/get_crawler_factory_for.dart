import 'package:chapturn/data/failure.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';

class GetCrawlerFactoryFor {
  final CrawlerRepository _crawlerRepository;

  GetCrawlerFactoryFor(this._crawlerRepository);

  Future<Either<Failure, CrawlerFactory>> execute(String url) {
    return _crawlerRepository.crawlerFactoryFor(url);
  }
}
