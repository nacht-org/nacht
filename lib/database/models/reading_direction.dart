import 'package:drift/drift.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../exceptions/seed_exception.dart';

class ReadingDirections extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 32)();
}

abstract class ReadingDirectionSeed {
  static const int ltr = 1;
  static const int rtl = 2;

  static sources.ReadingDirection intoReadingDirection(
    int readingDirectionId,
  ) {
    switch (readingDirectionId) {
      case ReadingDirectionSeed.ltr:
        return sources.ReadingDirection.ltr;
      case ReadingDirectionSeed.rtl:
        return sources.ReadingDirection.rtl;
      default:
        throw SeedException();
    }
  }

  static int fromReadingDirection(sources.ReadingDirection entity) {
    switch (entity) {
      case sources.ReadingDirection.ltr:
        return ReadingDirectionSeed.ltr;
      case sources.ReadingDirection.rtl:
        return ReadingDirectionSeed.rtl;
    }
  }
}
