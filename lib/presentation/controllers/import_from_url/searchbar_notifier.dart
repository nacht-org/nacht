import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImportUrlSearchBarNotifier extends StateNotifier<String> {
  ImportUrlSearchBarNotifier(String state) : super(state);

  void change(String value) {
    state = value;
  }

  void paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    state = data?.text ?? '';
  }

  void clear() {
    state = '';
  }
}

final importUrlSearchBarProvider =
    StateNotifierProvider<ImportUrlSearchBarNotifier, String>(
        (ref) => ImportUrlSearchBarNotifier(''));
