import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

import '../providers/categories_page_provider.dart';

class EditCategoryDialog extends HookConsumerWidget {
  const EditCategoryDialog({Key? key, required this.categoryData})
      : super(key: key);

  final CategoryData categoryData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(categoriesPageProvider.notifier);
    final controller = useTextEditingController();

    useEffect(() {
      controller.text = categoryData.name;
      return null;
    });

    void submit() {
      // TODO: Add proper validation.
      assert(controller.value.text.isNotEmpty);

      notifier.edit(categoryData, controller.value.text);
      context.router.pop();
    }

    return AlertDialog(
      title: const Text('Edit category'),
      content: TextField(
        autofocus: true,
        controller: controller,
        onEditingComplete: submit,
      ),
      actions: [
        TextButton(
          onPressed: context.router.pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: submit,
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
