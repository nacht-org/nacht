import 'package:flutter/material.dart';
import 'package:nacht/nht/core/preferences/preference_key.dart';

class ReaderColorModeValue {
  const ReaderColorModeValue({
    required this.brightness,
    required this.textColor,
    required this.backgroundColor,
  });

  final Brightness brightness;
  final Color textColor;
  final Color backgroundColor;
}

enum ReaderColorMode implements EnumPreference {
  none(
    id: 0,
    name: 'None',
    value: null,
  ),
  white(
    id: 1,
    name: 'White',
    value: ReaderColorModeValue(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
    ),
  ),
  sepia(
    id: 2,
    name: 'Sepia',
    value: ReaderColorModeValue(
      brightness: Brightness.light,
      backgroundColor: Color(0xFFFBF0D9),
      textColor: Color.fromARGB(255, 95, 75, 50),
    ),
  ),
  black(
    id: 3,
    name: 'Black',
    value: ReaderColorModeValue(
      brightness: Brightness.dark,
      backgroundColor: Colors.black,
      textColor: Colors.white70,
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
        return ReaderColorMode.white;
      case 2:
        return ReaderColorMode.sepia;
      case 3:
        return ReaderColorMode.black;
    }

    throw Exception("error parsing reader.font-family");
  }
}
