import 'package:chapturn/components/novel/model/description_info.dart';
import 'package:chapturn/domain/entities/novel/novel_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
