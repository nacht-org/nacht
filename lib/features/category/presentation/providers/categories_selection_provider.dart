import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';

final categoriesSelectionProvider =
    StateNotifierProvider.autoDispose<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(SelectionInfo.initial()),
);
