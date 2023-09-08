import 'package:nacht/features/features.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMetaData = MetaEntry(
    id: 6,
    name: 'subject',
    value: 'tvalue',
    namespaceId: NamespaceSeed.opf,
    others: '{"href":"https://website.com/link"}',
    novelId: 2,
  );

  final tData = MetaEntryData(
    id: 6,
    name: 'subject',
    value: 'tvalue',
    namespace: sources.Namespace.opf,
    others: {'href': 'https://website.com/link'},
    novelId: 2,
  );

  test('should create MetaData from data.MetaData', () {
    final result = MetaEntryData.fromModel(tMetaData);
    print(result.others);

    expect(result, tData);
  });
}
