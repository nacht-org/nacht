import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

void main() {
  test('should convert sources.MetaData into MetaDatasCompanion', () {
    final tSource = sources.MetaData('subject', 'tvalue', {});

    const tCompanion = MetaEntriesCompanion(
      name: Value('subject'),
      value: Value('tvalue'),
      namespaceId: Value(NamespaceSeed.dc),
      others: Value(null),
    );

    final result = sourceMetaDataIntoCompanion(tSource);
    expect(result, tCompanion);
  });
}
