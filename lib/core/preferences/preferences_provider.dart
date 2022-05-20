import 'package:chapturn/extrinsic/extrinsic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
  name: 'SharedPreferencesProvider',
);

final preferencesProvider = Provider.family<Preferences, String?>(
  (ref, prefix) => Preferences.basic(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    prefix: prefix,
  ),
  name: 'PreferencesProvider',
);
