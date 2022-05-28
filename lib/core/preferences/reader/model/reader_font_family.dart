enum ReaderFontFamily {
  basic,
  lato,
}

extension ReaderFontFamilyExtension on ReaderFontFamily {
  int get value {
    switch (this) {
      case ReaderFontFamily.basic:
        return 0;
      case ReaderFontFamily.lato:
        return 1;
    }
  }

  String get name {
    switch (this) {
      case ReaderFontFamily.basic:
        return 'Default';
      case ReaderFontFamily.lato:
        return 'Lato';
    }
  }
}

ReaderFontFamily parseReaderFontFamily(int id) {
  switch (id) {
    case 0:
      return ReaderFontFamily.basic;
    case 1:
      return ReaderFontFamily.lato;
  }

  throw Exception("error parsing reader.font-family");
}
