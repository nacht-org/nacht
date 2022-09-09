import 'package:nacht/nht/core/preferences/preference_key.dart';

enum OrderPreference implements EnumPreference {
  ascending(0, "Ascending"),
  descending(1, "Descending");

  const OrderPreference(this.id, this.name);

  @override
  final int id;
  final String name;

  factory OrderPreference.parse(int id) {
    switch (id) {
      case 0:
        return OrderPreference.ascending;
      case 1:
        return OrderPreference.descending;
    }

    throw Exception("error parsing chapter_list.order");
  }
}
