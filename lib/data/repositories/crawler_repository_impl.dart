import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/mapper.dart';
import '../../domain/repositories/crawler_repository.dart';

class CrawlerRepositoryImpl implements CrawlerRepository {
  CrawlerRepositoryImpl(this.partialFromNovelMapper);

  final Mapper<Novel, PartialNovelEntity> partialFromNovelMapper;

  @override
  Either<Failure, CrawlerFactory> crawlerFactoryFor(String url) {
    final crawler = sources.crawlerFactoryFor(url);
    if (crawler == null) {
      return const Left(CrawlerNotFound());
    } else {
      return Right(crawler);
    }
  }

  @override
  Either<Failure, List<CrawlerFactory>> getAllCrawlers() {
    return const Right(crawlers);
  }

  @override
  Future<Either<Failure, List<PartialNovelEntity>>> getPopularNovels(
    ParsePopular parser,
    int page,
  ) async {
    final novels = await parser.parsePopular(page);

    final entities =
        novels.map((novel) => partialFromNovelMapper.from(novel)).toList();

    return Right(entities);
  }
}
