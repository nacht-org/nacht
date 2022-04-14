import 'package:chapturn/data/failure.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';

class GetAllCrawlers {
  final CrawlerRepository _crawlerRepository;

  GetAllCrawlers(this._crawlerRepository);

  Future<Either<Failure, List<CrawlerFactory>>> execute() {
    return _crawlerRepository.getAllCrawlers();
  }
}
