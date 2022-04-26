import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/database_mappers/seed_mappers/namespace_mapper.dart';
import 'package:chapturn/data/mappers/mappers.dart';
import 'package:chapturn/data/mappers/network/connection_mapper.dart';
import 'package:chapturn/data/mappers/sources/partial_novel_source_mapper.dart';
import 'package:chapturn/domain/entities/entities.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

final partialNovelSourceFromMapper =
    Provider<SourceToPartialNovelMapper>((ref) => SourceToPartialNovelMapper());

final connectivityToConnectionMapper = Provider<ConnectivityToConnectionMapper>(
    ((ref) => ConnectivityToConnectionMapper()));

// To seeds.

final novelStatusToSeedMapper = Provider<Mapper<sources.NovelStatus, int>>(
    (ref) => NovelStatusToSeedMapper());

final workTypeToSeedMapper =
    Provider<Mapper<sources.WorkType, int>>((ref) => WorkTypeToSeedMapper());

final readingDirectionToSeedMapper =
    Provider<Mapper<sources.ReadingDirection, int>>(
        (ref) => ReadingDirectionToSeedMapper());

final namespaceToSeedMapper =
    Provider<Mapper<sources.Namespace, int>>((ref) => NamespaceToSeedMapper());

// From seeds.

final seedToNovelStatusMapper = Provider<Mapper<int, sources.NovelStatus>>(
    (ref) => SeedToNovelStatusMapper());

final seedToWorkTypeMapper =
    Provider<Mapper<int, sources.WorkType>>((ref) => SeedToWorkTypeMapper());

final seedToReadingDirectionMapper =
    Provider<Mapper<int, sources.ReadingDirection>>(
        (ref) => SeedToReadingDirectionMapper());

final seedToNamespaceMapper =
    Provider<Mapper<int, sources.Namespace>>((ref) => SeedToNamespaceMapper());

// Companions.

final sourceToNovelCompanionMapper =
    Provider<Mapper<sources.Novel, NovelsCompanion>>(
  (ref) => SourceToNovelCompanionMapper(
    statusMapper: ref.watch(novelStatusToSeedMapper),
    workTypeMapper: ref.watch(workTypeToSeedMapper),
    readingDirectionMapper: ref.watch(readingDirectionToSeedMapper),
  ),
);

final sourceToVolumeCompanionMapper =
    Provider<Mapper<sources.Volume, VolumesCompanion>>(
        (ref) => SourceToVolumeCompanionMapper());

final sourceToChapterCompanionMapper =
    Provider<Mapper<sources.Chapter, ChaptersCompanion>>(
        (ref) => SourceToChapterCompanionMapper());

final sourceToMetaDataCompanionMapper =
    Provider<Mapper<sources.MetaData, MetaDatasCompanion>>(
  (ref) => SourceToMetaDataCompanionMapper(ref.watch(namespaceToSeedMapper)),
);

// Models.
final databaseToNovelMapper =
    Provider<Mapper<Novel, NovelEntity>>((ref) => DatabaseToNovelMapper(
          statusMapper: ref.watch(seedToNovelStatusMapper),
          readingDirectionMapper: ref.watch(seedToReadingDirectionMapper),
          workTypeMapper: ref.watch(seedToWorkTypeMapper),
        ));

final databaseToVolumeMapper =
    Provider<Mapper<Volume, VolumeEntity>>((ref) => DatabaseToVolumeMapper());

final databaseToChapterMapper = Provider<Mapper<Chapter, ChapterEntity>>(
    (ref) => DatabaseToChapterMapper());

final databaseToMetaDataMapper = Provider<Mapper<MetaData, MetaDataEntity>>(
    (ref) => DatabaseToMetaDataMapper(ref.watch(seedToNamespaceMapper)));

final databaseToCategoryMapper =
    Provider<Mapper<NovelCategory, CategoryEntity>>(
  (ref) => DatabaseToCategoryMapper(),
);
