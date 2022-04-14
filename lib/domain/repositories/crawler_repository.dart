import 'package:chapturn/data/failure.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';

abstract class CrawlerRepository {
  Future<Either<Failure, CrawlerFactory>> crawlerFactoryFor(String url);
  Either<Failure, List<CrawlerFactory>> getAllCrawlers();
}
