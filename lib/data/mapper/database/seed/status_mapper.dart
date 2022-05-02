import 'package:chapturn_sources/chapturn_sources.dart';

import '../../../exception.dart';
import '../../../models/status.dart';
import '../../../../domain/mapper.dart';

class NovelStatusToSeedMapper implements Mapper<NovelStatus, int> {
  @override
  int from(NovelStatus entity) {
    switch (entity) {
      case NovelStatus.ongoing:
        return StatusSeed.ongoing;
      case NovelStatus.hiatus:
        return StatusSeed.hiatus;
      case NovelStatus.completed:
        return StatusSeed.completed;
      case NovelStatus.unknown:
        return StatusSeed.unknown;
    }
  }
}

class SeedToNovelStatusMapper implements Mapper<int, NovelStatus> {
  @override
  NovelStatus from(int model) {
    switch (model) {
      case StatusSeed.ongoing:
        return NovelStatus.ongoing;
      case StatusSeed.hiatus:
        return NovelStatus.hiatus;
      case StatusSeed.completed:
        return NovelStatus.completed;
      case StatusSeed.unknown:
        return NovelStatus.unknown;
      default:
        throw SeedException();
    }
  }
}
