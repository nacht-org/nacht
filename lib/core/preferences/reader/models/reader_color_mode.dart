import 'package:flutter/material.dart';
import 'package:nacht/nht/core/preferences/preference_key.dart';

class ReaderColorModeValue {
  const ReaderColorModeValue({
    required this.brightness,
    required this.backgroundColor,
  });

  final Brightness brightness;
  final Color backgroundColor;
}

enum ReaderColorMode implements EnumPreference {
  none(
    id: 0,
    name: 'None',
    value: null,
  ),
  white(
    id: 2,
    name: 'White',
    value: ReaderColorModeValue(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
    ),
  ),
  black(
    id: 1,
    name: 'Black',
    value: ReaderColorModeValue(
      brightness: Brightness.dark,
      backgroundColor: Colors.black,
    ),
  );

  const ReaderColorMode({
    required this.id,
    required this.name,
    required this.value,
  });

  @override
  final int id;
  final String name;
  final ReaderColorModeValue? value;

  factory ReaderColorMode.parse(int id) {
    switch (id) {
      case 0:
        return ReaderColorMode.none;
      case 1:
        return ReaderColorMode.black;
      case 2:
        return ReaderColorMode.white;
    }

    throw Exception("error parsing reader.font-family");
  }
}
