import 'dart:io';
import 'dart:isolate';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'database.dart';

part 'app_database.g.dart';

final databaseProvider = Provider<AppDatabase>(
  (ref) => AppDatabase(),
);

@DriftDatabase(tables: [
  Novels,
  Statuses,
  WorkTypes,
  ReadingDirections,
  NovelCategories,
  NovelCategoriesJunction,
  Volumes,
  Chapters,
  MetaEntries,
  Namespaces,
  Assets,
  AssetTypes,
  Updates,
  ReadingHistories,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.connect() : super.connect(_createDriftIsolateAndConnect());

  @override
  int get schemaVersion => 3;

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
              categoryIndex: 0,
              name: 'Default',
            )
          ]);

          batch.insertAll(statuses, [
            StatusesCompanion.insert(id: const Value(1), value: 'Ongoing'),
            StatusesCompanion.insert(id: const Value(2), value: 'Hiatus'),
            StatusesCompanion.insert(id: const Value(3), value: 'Completed'),
            StatusesCompanion.insert(id: const Value(4), value: 'stub'),
            StatusesCompanion.insert(id: const Value(5), value: 'Unknown'),
          ]);

          batch.insertAll(namespaces, [
            NamespacesCompanion.insert(id: const Value(1), value: 'dc'),
            NamespacesCompanion.insert(id: const Value(2), value: 'opf'),
          ]);

          batch.insertAll(assetTypes, [
            AssetTypesCompanion.insert(
                id: const Value(1), mimetype: 'image/apng'),
            AssetTypesCompanion.insert(
                id: const Value(2), mimetype: 'image/avif'),
            AssetTypesCompanion.insert(
                id: const Value(3), mimetype: 'image/gif'),
            AssetTypesCompanion.insert(
                id: const Value(4), mimetype: 'image/jpeg'),
            AssetTypesCompanion.insert(
                id: const Value(5), mimetype: 'image/png'),
            AssetTypesCompanion.insert(
                id: const Value(6), mimetype: 'image/svg+xml'),
            AssetTypesCompanion.insert(
                id: const Value(7), mimetype: 'image/webp'),
            AssetTypesCompanion.insert(
                id: const Value(8), mimetype: 'text/html'),
            AssetTypesCompanion.insert(
                id: const Value(9), mimetype: 'text/css'),
          ]);
        });
      },
      onUpgrade: (Migrator m, int from, int to) async {
        await customStatement('PRAGMA foreign_keys = OFF');

        if (from < 2) {
          await batch((batch) {
            batch.insertAll(assetTypes, [
              AssetTypesCompanion.insert(
                  id: const Value(8), mimetype: 'text/html'),
              AssetTypesCompanion.insert(
                  id: const Value(9), mimetype: 'text/css'),
            ]);
          });
        }

        if (from < 3) {
          await m.createTable(readingHistories);
        }

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

Future<DriftIsolate> _createDriftIsolate() async {
  final dir = await getApplicationDocumentsDirectory();
  final path = p.join(dir.path, 'db.sqlite');
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, path),
  );

  return await receivePort.first as DriftIsolate;
}

void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));

  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );

  request.sendDriftIsolate.send(driftIsolate);
}

class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

DatabaseConnection _createDriftIsolateAndConnect() {
  return DatabaseConnection.delayed(() async {
    final isolate = await _createDriftIsolate();
    return await isolate.connect();
  }());
}
