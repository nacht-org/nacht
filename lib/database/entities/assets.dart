import 'package:drift/drift.dart';

import '../exceptions/seed_exception.dart';

class Assets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text().nullable()();
  TextColumn get path => text().nullable()();
  TextColumn get hash => text().withLength(max: 40)();
  IntColumn get typeId => integer().references(AssetTypes, #id)();
  DateTimeColumn get savedAt => dateTime()();
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

  static int fromMimeType(String mimeType) {
    switch (mimeType) {
      case 'image/apng':
        return 1;
      case 'image/avif':
        return 2;
      case 'image/gif':
        return 3;
      case 'image/jpeg':
        return 4;
      case 'image/png':
        return 5;
      case 'image/svg+xml':
        return 6;
      case 'image/webp':
        return 7;
      default:
        throw SeedException();
    }
  }

  static String intoMimeType(int assetTypeId) {
    switch (assetTypeId) {
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
        throw SeedException();
    }
  }
}
