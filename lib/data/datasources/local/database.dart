import 'dart:io';

import '../../models/models.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [
  Novels,
  Statuses,
  WorkTypes,
  ReadingDirections,
  NovelCategories,
  NovelCategoriesJunction,
  Volumes,
  Chapters,
  MetaDatas,
  Namespaces,
  Assets,
  AssetTypes,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // Seeding.
        await batch((batch) {
          // ReadingDirections
          batch.insertAll(readingDirections, [
            ReadingDirectionsCompanion.insert(
              id: const Value(1),
              value: 'ltr',
            ),
            ReadingDirectionsCompanion.insert(
              id: const Value(2),
              value: 'rtl',
            ),
          ]);

          // WorkTypes
          batch.insertAll(workTypes, [
            WorkTypesCompanion.insert(
              id: const Value(1),
              value: 'original',
            ),
            WorkTypesCompanion.insert(
              id: const Value(2),
              value: 'translation_mtl',
            ),
            WorkTypesCompanion.insert(
              id: const Value(3),
              value: 'translation_human',
            ),
            WorkTypesCompanion.insert(
              id: const Value(4),
              value: 'translation_unknown',
            ),
            WorkTypesCompanion.insert(
              id: const Value(5),
              value: 'unknown',
            ),
          ]);

          batch.insertAll(novelCategories, [
            NovelCategoriesCompanion.insert(
              id: const Value(1),
              name: '_default',
            )
          ]);

          batch.insertAll(statuses, [
            StatusesCompanion.insert(id: const Value(1), value: 'Completed'),
            StatusesCompanion.insert(id: const Value(2), value: 'Ongoing'),
            StatusesCompanion.insert(id: const Value(3), value: 'Hiatus'),
            StatusesCompanion.insert(id: const Value(4), value: 'Unknown'),
          ]);

          batch.insertAll(namespaces, [
            NamespacesCompanion.insert(id: const Value(1), value: 'dc'),
            NamespacesCompanion.insert(id: const Value(2), value: 'opf'),
          ]);

          batch.insertAll(assetTypes, [
            AssetTypesCompanion.insert(
                id: const Value(1), type: 'image', subType: 'apng'),
            AssetTypesCompanion.insert(
                id: const Value(2), type: 'image', subType: 'avif'),
            AssetTypesCompanion.insert(
                id: const Value(3), type: 'image', subType: 'gif'),
            AssetTypesCompanion.insert(
                id: const Value(4), type: 'image', subType: 'jpeg'),
            AssetTypesCompanion.insert(
                id: const Value(5), type: 'image', subType: 'png'),
            AssetTypesCompanion.insert(
                id: const Value(6), type: 'image', subType: 'svg+xml'),
            AssetTypesCompanion.insert(
                id: const Value(7), type: 'image', subType: 'webp'),
          ]);
        });
      },
      onUpgrade: (Migrator m, int from, int to) async {
        await customStatement('PRAGMA foreign_keys = OFF');

        // Add migrations as required starting from 2
        // if (from < 2) {
        //   // Migrate to version 2
        // }

        // Assert that the schema is valid after migrations
        if (kDebugMode) {
          final wrongForeignKeys =
              await customSelect('PRAGMA foreign_key_check').get();
          assert(wrongForeignKeys.isEmpty,
              '${wrongForeignKeys.map((e) => e.data)}');
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
