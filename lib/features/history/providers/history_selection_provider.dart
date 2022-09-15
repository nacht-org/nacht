import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

final historySelectionProvider =
    StateNotifierProvider.autoDispose<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(SelectionInfo.initial()),
  name: "HistorySelectionProvider",
);
