import 'package:chapturn_sources/chapturn_sources.dart';

import '../../../../domain/mapper.dart';
import '../../../exception.dart';
import '../../../models/reading_direction.dart';

class ReadingDirectionToSeedMapper implements Mapper<ReadingDirection, int> {
  @override
  int from(ReadingDirection entity) {
    switch (entity) {
      case ReadingDirection.ltr:
        return ReadingDirectionSeed.ltr;
      case ReadingDirection.rtl:
        return ReadingDirectionSeed.rtl;
    }
  }
}

class SeedToReadingDirectionMapper implements Mapper<int, ReadingDirection> {
  @override
  ReadingDirection from(int model) {
    switch (model) {
      case ReadingDirectionSeed.ltr:
        return ReadingDirection.ltr;
      case ReadingDirectionSeed.rtl:
        return ReadingDirection.rtl;
      default:
        throw SeedException();
    }
  }
}
