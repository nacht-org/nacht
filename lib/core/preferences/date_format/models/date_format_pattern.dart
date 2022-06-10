import 'package:nacht/nht/nht.dart';

// TODO: test id value is unique
enum DateFormatPattern implements EnumPreference {
  basic(0, "Default", pattern: "dd-MM-yyyy");

  const DateFormatPattern(
    this.id,
    this.name, {
    required this.pattern,
  });

  @override
  final int id;
  final String name;
  final String pattern;

  factory DateFormatPattern.parse(int id) {
    switch (id) {
      case 0:
        return DateFormatPattern.basic;
    }

    throw Exception("error parsing date-format.date-format-pattern");
  }
}
