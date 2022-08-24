import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

void main() {
  test('should convert sources.Volume into VolumesCompanion', () {
    final tSource = sources.Volume(
      index: 1,
      name: 'volume 1',
    );

    const tCompanion = VolumesCompanion(
      volumeIndex: Value(1),
      name: Value('volume 1'),
    );

    final result = sourceVolumeIntoCompanion(tSource);
    expect(result, tCompanion);
  });
}
