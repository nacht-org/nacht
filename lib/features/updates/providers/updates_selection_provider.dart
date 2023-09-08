import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

final updatesSelectionProvider =
    StateNotifierProvider.autoDispose<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(
    SelectionInfo.initial(),
  ),
  name: "UpdatesSelectionProvider",
);
