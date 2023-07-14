import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/models.dart';

final homeIndexProvider =
    StateNotifierProvider<HomeIndexNotifier, int>((ref) => HomeIndexNotifier());

class HomeIndexNotifier extends StateNotifier<int> {
  HomeIndexNotifier() : super(0);

  void setIndex(int newIndex) {
    state = newIndex;
  }

  void setDestination(Destination destination) {
    state = destinations.indexed
        .firstWhere((record) => record.$2 == destination)
        .$1;
  }
}
