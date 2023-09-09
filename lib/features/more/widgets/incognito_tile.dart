import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';
import 'package:material_symbols_icons/symbols.dart';

class IncognitoTile extends ConsumerWidget {
  const IncognitoTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incognito = ref.watch(incognitoProvider);
    final incognitoNotifier = ref.watch(incognitoProvider.notifier);

    return SwitchListTile(
      secondary: const Icon(Symbols.eyeglasses),
      title: const Text('Incognito mode'),
      subtitle: const Text('Pauses reading history'),
      value: incognito,
      onChanged: incognitoNotifier.setIncognito,
      contentPadding: kTrailingListTilePadding,
    );
  }
}
