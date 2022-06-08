import 'package:nacht/nht/nht.dart';

// TODO: test id value is unique
enum ReaderFontFamily implements EnumPreference {
  basic(0, "Default"),
  lato(1, "Lato");

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
    }

    throw Exception("error parsing reader.font-family");
  }
}
