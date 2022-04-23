import 'package:chapturn/data/repositories/crawler_repository_impl.dart';
import 'package:chapturn/data/repositories/network_repository_impl.dart';
import 'package:chapturn/data/repositories/novel_repository/novel_local_repository_impl.dart';
import 'package:chapturn/data/repositories/novel_repository/novel_remote_repository_impl.dart';
import 'package:chapturn/domain/providers/datasources_provider.dart';
import 'package:chapturn/domain/providers/mapper_providers.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final crawlerRepository = Provider<CrawlerRepository>(
    (ref) => CrawlerRepositoryImpl(ref.watch(partialNovelSourceFromMapper)));

final networkRepository = Provider<NetworkRepository>(
  (ref) => NetworkRepositoryImpl(ref.watch(connectivityToConnectionMapper)),
);

final novelRemoteRepository = Provider<NovelRemoteRepository>(
  (ref) => NovelRemoteRepositoryImpl(),
);

final novelLocalRepository = Provider<NovelLocalRepository>((ref) {
  return NovelLocalRepositoryImpl(database: ref.watch(databaseProvider), novelCompanionMapper: ref.watch(sourceToNovelCompanionMapper), volumeCompanionMapper: ref.watch(sourceToVolumeCompanionMapper), chapterCompanionMapper: ref.watch(sourceToChapterCompanionMapper), novelMapper: novelMapper, volumeMapper: volumeMapper, chapterMapper: chapterMapper,),
});