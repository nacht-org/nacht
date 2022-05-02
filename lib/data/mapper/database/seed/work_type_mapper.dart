import 'package:chapturn_sources/chapturn_sources.dart';

import '../../../exception.dart';
import '../../../models/work_type.dart';
import '../../../../domain/mapper.dart';

class WorkTypeToSeedMapper implements Mapper<WorkType, int> {
  @override
  int from(WorkType input) {
    if (input is OriginalWork) {
      return WorkTypeSeed.original;
    } else if (input is TranslatedWork) {
      switch (input.type) {
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

class SeedToWorkTypeMapper extends Mapper<int, WorkType> {
  @override
  WorkType from(int input) {
    switch (input) {
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
}
