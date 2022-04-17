import 'dart:io';

import 'package:chapturn/generated/migrations.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:modinate/modinate.dart';

void main() {
  test('migrations should be synced with filesystem', () async {
    final files = await Directory('assets/migrations').list().toList();
    final migrationFromFiles = files
        .where((file) => path.extension(file.path) == '.sql')
        .map((file) => Migration.fromPath(file.path))
        .toList();

    expect(
      migrations,
      migrationFromFiles,
      reason:
          'Migration information is outdated.\nRun "flutter pub run build_runner build --delete-conflicting-outputs" to update generated migration information.',
    );
  });

  test('migrations should be incremental', () async {
    if (migrations.isEmpty) {
      return;
    }

    int expectedVersion = 1;
    for (final migration in migrations) {
      expect(migration.number, expectedVersion);
      expectedVersion++;
    }
  });
}
