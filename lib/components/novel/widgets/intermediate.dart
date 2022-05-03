import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/providers.dart';
import 'novel_view.dart';
import 'partial_view.dart';

class Intermediate extends ConsumerWidget {
  const Intermediate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(novelPageState);

    return state.when(
      partial: (novel) {
        return PartialView(
          novel: novel,
        );
      },
      loaded: (novel) {
        return ProviderScope(
          overrides: [
            novelOverrideProvider.overrideWithValue(novel),
          ],
          child: const NovelView(),
        );
      },
    );
  }
}
