import 'package:chapturn/core/failure.dart';
import 'package:chapturn/data/mappers/mapper.dart';
import 'package:chapturn/domain/entities/partial_novel_entity.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

class CrawlerRepositoryImpl implements CrawlerRepository {
  CrawlerRepositoryImpl(this.partialFromNovelMapper);

  final MapFrom<PartialNovelEntity, Novel> partialFromNovelMapper;

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
    NovelPopular parser,
    int page,
  ) async {
    final novels = await parser.parsePopular(page);

    final entities =
        novels.map((novel) => partialFromNovelMapper.mapFrom(novel)).toList();

    return Right(entities);
  }
}
