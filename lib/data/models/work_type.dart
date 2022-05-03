import 'package:drift/drift.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

import '../exception.dart';

class WorkTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 32)();
}

abstract class WorkTypeSeed {
  static const int original = 1;
  static const int translationMtl = 2;
  static const int translationHuman = 3;
  static const int translationUnknown = 4;
  static const int unknown = 5;

  static sources.WorkType intoWorkType(int workTypeId) {
    switch (workTypeId) {
      case WorkTypeSeed.original:
        return const sources.OriginalWork();
      case WorkTypeSeed.translationMtl:
        return const sources.TranslatedWork.mtl();
      case WorkTypeSeed.translationHuman:
        return const sources.TranslatedWork.human();
      case WorkTypeSeed.translationUnknown:
        return const sources.TranslatedWork.unknown();
      case WorkTypeSeed.unknown:
        return const sources.UnknownWorkType();
      default:
        throw SeedException();
    }
  }

  static int fromWorkType(sources.WorkType input) {
    if (input is sources.OriginalWork) {
      return WorkTypeSeed.original;
    } else if (input is sources.TranslatedWork) {
      switch (input.type) {
        case sources.TranslationType.mtl:
          return WorkTypeSeed.translationMtl;
        case sources.TranslationType.human:
          return WorkTypeSeed.translationHuman;
        case sources.TranslationType.unknown:
          return WorkTypeSeed.translationUnknown;
      }
    } else {
      return WorkTypeSeed.unknown;
    }
  }
}
