import 'package:hooks_riverpod/hooks_riverpod.dart';

final isSearchingProvider = StateProvider<bool>(
  (ref) => false,
  name: 'IsSearchingProvider',
);
