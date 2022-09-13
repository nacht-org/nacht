import 'package:nacht/nht/nht.dart';

enum RelativeTimestamp implements EnumPreference {
  none(0, "None"),
  short(1, "Short (Today, Yesterday)"),
  long(2, "Long (Short+, n days ago)");

  const RelativeTimestamp(this.id, this.name);

  @override
  final int id;
  final String name;

  static RelativeTimestamp parse(int id) {
    switch (id) {
      case 0:
        return RelativeTimestamp.none;
      case 1:
        return RelativeTimestamp.short;
      case 2:
        return RelativeTimestamp.long;
    }

    throw Exception("error parsing date-format.relative-timestamp");
  }
}
