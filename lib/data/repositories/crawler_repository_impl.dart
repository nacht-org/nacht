import 'package:nacht_sources/nacht_sources.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
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
    // TODO: catch errors
    final novels = await parser.parsePopular(page);

    final entities =
        novels.map((novel) => PartialNovelData.fromSource(novel)).toList();

    return Right(entities);
  }

  @override
  Future<Either<Failure, List<PartialNovelData>>> getSearchNovels(
      ParseSearch parser, String query, int page) async {
    // TODO: catch errors
    final novels = await parser.search(query, page);

    final entities = novels.map(PartialNovelData.fromSource).toList();

    return Right(entities);
  }
}
