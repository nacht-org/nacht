import 'package:drift/drift.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

import '../exception.dart';

@DataClassName('Status')
class Statuses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 32)();
}

abstract class StatusSeed {
  static const int ongoing = 1;
  static const int hiatus = 2;
  static const int completed = 3;
  static const int unknown = 4;

  static sources.NovelStatus intoStatus(int statusId) {
    switch (statusId) {
      case StatusSeed.ongoing:
        return sources.NovelStatus.ongoing;
      case StatusSeed.hiatus:
        return sources.NovelStatus.hiatus;
      case StatusSeed.completed:
        return sources.NovelStatus.completed;
      case StatusSeed.unknown:
        return sources.NovelStatus.unknown;
      default:
        throw SeedException();
    }
  }

  static int fromStatus(sources.NovelStatus entity) {
    switch (entity) {
      case sources.NovelStatus.ongoing:
        return StatusSeed.ongoing;
      case sources.NovelStatus.hiatus:
        return StatusSeed.hiatus;
      case sources.NovelStatus.completed:
        return StatusSeed.completed;
      case sources.NovelStatus.unknown:
        return StatusSeed.unknown;
    }
  }
}
