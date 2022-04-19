import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entities/entities.dart';

class GetPopularNovels {
  GetPopularNovels({required this.crawlerRepository});

  final CrawlerRepository crawlerRepository;

  Future<Either<Failure, List<PartialNovelEntity>>> execute(
      NovelPopular parser) {
    return crawlerRepository.getPopularNovels(parser);
  }
}
