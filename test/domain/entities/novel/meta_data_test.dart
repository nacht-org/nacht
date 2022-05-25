import 'package:nacht/data/data.dart' as data;
import 'package:nacht/domain/domain.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMetaData = data.MetaEntry(
    id: 6,
    name: 'subject',
    value: 'tvalue',
    namespaceId: data.NamespaceSeed.opf,
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
