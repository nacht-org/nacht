import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/provider.dart';

final categoriesSelectionProvider =
    StateNotifierProvider<SelectionNotifier, SelectionInfo>(
  (ref) => SelectionNotifier(SelectionInfo.initial()),
);
