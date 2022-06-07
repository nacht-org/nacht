import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/components.dart';

final novelSelectionProvider =
    StateNotifierProvider.autoDispose<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(SelectionInfo.initial()),
);
