import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nacht/nht/nht.dart';

// TODO: test id value is unique
enum ReaderFontFamily implements EnumPreference {
  basic(0, "Default"),
  lato(1, "Lato"),
  openSans(2, "Open Sans");

  const ReaderFontFamily(this.id, this.name);

  @override
  final int id;
  final String name;

  factory ReaderFontFamily.parse(int id) {
    switch (id) {
      case 0:
        return ReaderFontFamily.basic;
      case 1:
        return ReaderFontFamily.lato;
      case 2:
        return ReaderFontFamily.openSans;
    }

    throw Exception("error parsing reader.font-family");
  }

  TextTheme? getTextTheme([TextTheme? textTheme]) {
    switch (this) {
      case ReaderFontFamily.basic:
        break;
      case ReaderFontFamily.lato:
        return GoogleFonts.latoTextTheme(textTheme);
      case ReaderFontFamily.openSans:
        return GoogleFonts.openSansTextTheme(textTheme);
    }

    return textTheme;
  }
}
