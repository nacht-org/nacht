import 'package:nacht/nht/nht.dart';

enum SortPreference implements EnumPreference {
  source(0, "Source"),
  dateUpload(1, "Date upload");

  const SortPreference(this.id, this.name);

  @override
  final int id;
  final String name;

  factory SortPreference.parse(int id) {
    switch (id) {
      case 0:
        return SortPreference.source;
      case 1:
        return SortPreference.dateUpload;
    }

    throw Exception("error parsing chapter_list.order");
  }
}
