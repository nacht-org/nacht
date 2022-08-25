import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/providers.dart';

class AddCategoryDialog extends HookConsumerWidget {
  const AddCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(categoriesPageProvider.notifier);
    final controller = useTextEditingController();

    void submit() {
      notifier.add(controller.value.text);
      context.router.pop();
    }

    return AlertDialog(
      title: const Text('Add category'),
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
