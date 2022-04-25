import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/crawler_repository_impl.dart';
import '../../data/repositories/network_repository_impl.dart';
import '../../data/repositories/novel_repository/novel_local_repository_impl.dart';
import '../../data/repositories/novel_repository/novel_remote_repository_impl.dart';
import '../repositories/crawler_repository.dart';
import '../repositories/network_repository.dart';
import '../repositories/novel_repository.dart';
import 'datasources_provider.dart';
import 'mapper_providers.dart';

final crawlerRepository = Provider<CrawlerRepository>(
    (ref) => CrawlerRepositoryImpl(ref.watch(partialNovelSourceFromMapper)));

final networkRepository = Provider<NetworkRepository>(
  (ref) => NetworkRepositoryImpl(ref.watch(connectivityToConnectionMapper)),
);

final novelRemoteRepository = Provider<NovelRemoteRepository>(
  (ref) => NovelRemoteRepositoryImpl(),
);

final novelLocalRepository = Provider<NovelLocalRepository>((ref) {
  return NovelLocalRepositoryImpl(
    database: ref.watch(databaseProvider),
    novelCompanionMapper: ref.watch(sourceToNovelCompanionMapper),
    volumeCompanionMapper: ref.watch(sourceToVolumeCompanionMapper),
    chapterCompanionMapper: ref.watch(sourceToChapterCompanionMapper),
    metadataCompanionMapper: ref.watch(sourceToMetaDataCompanionMapper),
    novelMapper: ref.watch(databaseToNovelMapper),
    volumeMapper: ref.watch(databaseToVolumeMapper),
    chapterMapper: ref.watch(databaseToChapterMapper),
    metaDataMapper: ref.watch(databaseToMetaDataMapper),
  );
});
