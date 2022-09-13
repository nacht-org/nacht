import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';

final librarySelectionProvider =
    StateNotifierProvider.autoDispose<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(
    SelectionInfo.initial(),
  ),
  name: "LibrarySelectionProvider",
);
