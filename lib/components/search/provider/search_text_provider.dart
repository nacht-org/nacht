import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchTextProvider = StateProvider<String>(
  (ref) => '',
  name: 'SearchTextProvider',
);
