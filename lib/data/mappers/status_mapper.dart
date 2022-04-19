import 'package:chapturn_sources/chapturn_sources.dart';

import '../exception.dart';
import '../models/status.dart';
import 'mapper.dart';

class NovelStatusMapper implements Mapper<NovelStatus, int> {
  @override
  NovelStatus mapFrom(int model) {
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

  @override
  int mapTo(NovelStatus entity) {
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
