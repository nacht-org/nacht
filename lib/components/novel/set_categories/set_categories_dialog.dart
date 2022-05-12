import 'package:chapturn/components/novel/set_categories/provider/selected_categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';

class SetCategoriesDialog extends ConsumerWidget {
  const SetCategoriesDialog({
    Key? key,
    required Map<CategoryData, bool> categories,
  })  : _categories = categories,
        super(key: key);

  final Map<CategoryData, bool> _categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(selectedCategoriesProvider(_categories));
    final notifier =
        ref.watch(selectedCategoriesProvider(_categories).notifier);

    return AlertDialog(
      title: const Text('Set categories'),
      content: ListView(
        children: (categories.entries.toList()
              ..sort((a, b) => a.key.index.compareTo(b.key.index)))
            .where((entry) => !entry.key.isDefault)
            .map(
              (entry) => CheckboxListTile(
                key: Key('${entry.key.id}'),
                title: Text(entry.key.name),
                value: entry.value,
                onChanged: (value) =>
                    notifier.setSelected(entry.key.id, value!),
                dense: true,
              ),
            )
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(categories),
          child: const Text('Ok'),
        )
      ],
    );
  }
}
