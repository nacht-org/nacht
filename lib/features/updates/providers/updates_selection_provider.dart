import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/selection/providers/providers.dart';

final updatesSelectionProvider =
    StateNotifierProvider.autoDispose<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(
    SelectionInfo.initial(),
  ),
  name: "UpdatesSelectionProvider",
);
