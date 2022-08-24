import 'package:nacht/shared/shared.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/description_info.dart';

final descriptionInfoProvider =
    Provider.autoDispose.family<DescriptionInfo, NovelData>(
  (ref, data) {
    final tags = data.metadata
        .where((namespace) => namespace.name == 'subject')
        .map((namespace) => namespace.value)
        .toList();

    return DescriptionInfo(description: data.description, tags: tags);
  },
  name: 'DescriptionInfoProvider',
);
