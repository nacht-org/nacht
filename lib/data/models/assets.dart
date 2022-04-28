import 'package:drift/drift.dart';

class Assets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  IntColumn get typeId => integer().references(AssetTypes, #id)();
}

class AssetTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mimetype => text()();
}

abstract class AssetTypeSeed {
  static const int imageApng = 1;
  static const int imageAvif = 2;
  static const int imageGif = 3;
  static const int imageJpeg = 4;
  static const int imagePng = 5;
  static const int imageSvgXml = 6;
  static const int imageWebp = 7;

  static String mimetype(int id) {
    switch (id) {
      case 1:
        return 'image/apng';
      case 2:
        return 'image/avif';
      case 3:
        return 'image/gif';
      case 4:
        return 'image/jpeg';
      case 5:
        return 'image/png';
      case 6:
        return 'image/svg+xml';
      case 7:
        return 'image/webp';
      default:
        return '';
    }
  }
}
