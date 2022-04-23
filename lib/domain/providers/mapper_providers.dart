import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/database/reading_database_mapper.dart';
import 'package:chapturn/data/mappers/database/source_to_chapter_companion_mapper.dart';
import 'package:chapturn/data/mappers/database/source_to_novel_companion_mapper.dart';
import 'package:chapturn/data/mappers/database/source_to_volume_companion_mapper.dart';
import 'package:chapturn/data/mappers/database/status_mapper.dart';
import 'package:chapturn/data/mappers/database/work_type_mapper.dart';
import 'package:chapturn/data/mappers/network/connection_mapper.dart';
import 'package:chapturn/data/mappers/sources/partial_novel_source_mapper.dart';
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

// From seeds.

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
