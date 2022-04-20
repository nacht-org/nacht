import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier(int state) : super(state);

  void setIndex(int index) {
    state = index;
  }
}

final bottomNavigationIndex =
    StateNotifierProvider<BottomNavigationNotifier, int>(
        (ref) => BottomNavigationNotifier(0));
