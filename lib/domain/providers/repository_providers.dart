import 'package:chapturn/data/repositories/category/category_repository_impl.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repositories/crawler_repository_impl.dart';
import '../../data/repositories/network_repository_impl.dart';
import '../../data/repositories/novel/novel_local_repository_impl.dart';
import '../../data/repositories/novel/novel_remote_repository_impl.dart';
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

final categoryRepository = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    database: ref.watch(databaseProvider),
    categoryMapper: ref.watch(databaseToCategoryMapper),
    novelMapper: ref.watch(databaseToNovelMapper),
  ),
);
