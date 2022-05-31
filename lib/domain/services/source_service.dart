import 'package:nacht/core/core.dart';
import 'package:nacht/data/failure.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain.dart';

final sourceServiceProvider = Provider<SourceService>(
  (ref) => SourceService(
    crawlerRepository: ref.watch(crawlerRepositoryProvider),
    networkRepository: ref.watch(networkRepositoryProvider),
  ),
  name: 'SourceServiceProvider',
);

class SourceService with LoggerMixin {
  SourceService({
    required CrawlerRepository crawlerRepository,
    required NetworkRepository networkRepository,
  })  : _crawlerRepository = crawlerRepository,
        _networkRepository = networkRepository;

  final CrawlerRepository _crawlerRepository;
  final NetworkRepository _networkRepository;

  Option<sources.CrawlerFactory> crawlerFactoryFor({required String url}) {
    return _crawlerRepository.crawlerFactoryFor(url);
  }

  Either<Failure, List<sources.CrawlerFactory>> crawlers() {
    return _crawlerRepository.getAllCrawlers();
  }

  Future<Either<Failure, List<PartialNovelData>>> popular(
    sources.ParsePopular parser,
    int page,
  ) async {
    if (!await _networkRepository.isConnectionAvailable()) {
      return const Left(NetworkFailure("Connection not available"));
    }

    return _crawlerRepository.getPopularNovels(parser, page);
  }

  Future<Either<Failure, List<PartialNovelData>>> search(
    sources.ParseSearch parser,
    String query,
    int page,
  ) async {
    if (!await _networkRepository.isConnectionAvailable()) {
      return const Left(NetworkFailure("Connection not available"));
    }

    return _crawlerRepository.getSearchNovels(parser, query, page);
  }
}
