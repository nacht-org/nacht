import 'package:chapturn_sources/chapturn_sources.dart';

import '../exception.dart';
import '../models/work_type.dart';
import 'mapper.dart';

class WorkTypeMapper implements Mapper<WorkType, int> {
  @override
  WorkType mapFrom(int model) {
    switch (model) {
      case WorkTypeSeed.original:
        return const OriginalWork();
      case WorkTypeSeed.translationMtl:
        return const TranslatedWork.mtl();
      case WorkTypeSeed.translationHuman:
        return const TranslatedWork.human();
      case WorkTypeSeed.translationUnknown:
        return const TranslatedWork.unknown();
      case WorkTypeSeed.unknown:
        return const UnknownWorkType();
      default:
        throw SeedException();
    }
  }

  @override
  int mapTo(WorkType entity) {
    if (entity is OriginalWork) {
      return WorkTypeSeed.original;
    } else if (entity is TranslatedWork) {
      switch (entity.type) {
        case TranslationType.mtl:
          return WorkTypeSeed.translationMtl;
        case TranslationType.human:
          return WorkTypeSeed.translationHuman;
        case TranslationType.unknown:
          return WorkTypeSeed.translationUnknown;
      }
    } else {
      return WorkTypeSeed.unknown;
    }
  }
}
