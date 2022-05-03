import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../../domain/domain.dart';
import '../../domain/repositories/crawler_repository.dart';

class CrawlerRepositoryImpl implements CrawlerRepository {
  CrawlerRepositoryImpl();

  @override
  Option<CrawlerFactory> crawlerFactoryFor(String url) {
    final crawler = sources.crawlerFactoryFor(url);
    if (crawler == null) {
      return const None();
    } else {
      return Some(crawler);
    }
  }

  @override
  Either<Failure, List<CrawlerFactory>> getAllCrawlers() {
    return const Right(crawlers);
  }

  @override
  Future<Either<Failure, List<PartialNovelData>>> getPopularNovels(
    ParsePopular parser,
    int page,
  ) async {
    final novels = await parser.parsePopular(page);

    final entities =
        novels.map((novel) => PartialNovelData.fromSource(novel)).toList();

    return Right(entities);
  }
}
