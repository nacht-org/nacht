import 'package:drift/drift.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../exceptions/seed_exception.dart';

@DataClassName('Status')
class Statuses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 32)();
}

abstract class StatusSeed {
  static const int ongoing = 1;
  static const int hiatus = 2;
  static const int completed = 3;
  static const int stub = 4;
  static const int dropped = 6;
  static const int unknown = 5;

  static sources.NovelStatus intoStatus(int statusId) {
    return switch (statusId) {
      StatusSeed.ongoing => sources.NovelStatus.ongoing,
      StatusSeed.hiatus => sources.NovelStatus.hiatus,
      StatusSeed.completed => sources.NovelStatus.completed,
      StatusSeed.stub => sources.NovelStatus.stub,
      StatusSeed.dropped => sources.NovelStatus.dropped,
      StatusSeed.unknown => sources.NovelStatus.unknown,
      _ => throw SeedException(),
    };
  }

  static int fromStatus(sources.NovelStatus entity) {
    return switch (entity) {
      sources.NovelStatus.ongoing => StatusSeed.ongoing,
      sources.NovelStatus.hiatus => StatusSeed.hiatus,
      sources.NovelStatus.completed => StatusSeed.completed,
      sources.NovelStatus.stub => StatusSeed.stub,
      sources.NovelStatus.dropped => StatusSeed.dropped,
      sources.NovelStatus.unknown => StatusSeed.unknown,
    };
  }
}
