import 'package:chapturn/components/novel/model/description_info.dart';
import 'package:chapturn/domain/entities/novel/novel_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'novel_provider.dart';

final descriptionInfoProvider = Provider.autoDispose<DescriptionInfo>(
  (ref) {
    final data = ref.watch(novelProvider);
    final tags = data.metadata
        .where((namespace) => namespace.name == 'subject')
        .map((namespace) => namespace.value)
        .toList();

    return DescriptionInfo(description: data.description, tags: tags);
  },
  dependencies: [novelProvider],
  name: 'DescriptionInfoProvider',
);
