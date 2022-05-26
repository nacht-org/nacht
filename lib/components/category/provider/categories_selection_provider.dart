import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/provider.dart';

final categoriesSelectionProvider =
    StateNotifierProvider.autoDispose<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(SelectionInfo.initial()),
);
