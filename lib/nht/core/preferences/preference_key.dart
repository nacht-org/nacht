import 'package:nacht/nht/nht.dart';

abstract class PreferenceKey<T> {
  const PreferenceKey(this.key);

  final String key;

  T getValue(Preferences preferences, T defaultValue);
  void setValue(Preferences preferences, T value);
}

class IntPreferenceKey extends PreferenceKey<int> {
  const IntPreferenceKey(super.key);

  @override
  int getValue(Preferences preferences, int defaultValue) =>
      preferences.getInt(key, defaultValue);

  @override
  void setValue(Preferences preferences, int value) =>
      preferences.setInt(key, value);
}

class DoublePreferenceKey extends PreferenceKey<double> {
  const DoublePreferenceKey(super.key);

  @override
  double getValue(Preferences preferences, double defaultValue) =>
      preferences.getDouble(key, defaultValue);

  @override
  void setValue(Preferences preferences, double value) =>
      preferences.setDouble(key, value);
}

/// Provides a unique id for each [Enum]
abstract class EnumPreference {
  int get id;
}

class EnumPreferenceKey<T extends EnumPreference> extends PreferenceKey<T> {
  const EnumPreferenceKey(
    super.key, {
    required this.parse,
  });

  final T Function(int id) parse;

  @override
  T getValue(Preferences preferences, T defaultValue) =>
      parse(preferences.getInt(key, defaultValue.id));

  @override
  void setValue(Preferences preferences, T value) =>
      preferences.setInt(key, value.id);
}
