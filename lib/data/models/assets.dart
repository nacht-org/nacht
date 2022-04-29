import 'package:drift/drift.dart';

class Assets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text().nullable()();
  TextColumn get path => text().nullable()();
  TextColumn get hash => text().withLength(max: 40)();
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
}
