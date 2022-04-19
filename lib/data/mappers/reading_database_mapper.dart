import 'package:chapturn_sources/chapturn_sources.dart';

import 'mapper.dart';
import '../exception.dart';
import '../models/reading_direction.dart';

class ReadingDirectionMapper implements Mapper<ReadingDirection, int> {
  @override
  ReadingDirection mapFrom(int model) {
    switch (model) {
      case ReadingDirectionSeed.ltr:
        return ReadingDirection.ltr;
      case ReadingDirectionSeed.rtl:
        return ReadingDirection.rtl;
      default:
        throw SeedException();
    }
  }

  @override
  int mapTo(ReadingDirection entity) {
    switch (entity) {
      case ReadingDirection.ltr:
        return ReadingDirectionSeed.ltr;
      case ReadingDirection.rtl:
        return ReadingDirectionSeed.rtl;
    }
  }
}
