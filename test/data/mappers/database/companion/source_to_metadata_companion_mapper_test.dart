import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mapper/mapper.dart';
import 'package:chapturn/data/models/models.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:drift/drift.dart';
import 'package:mockito/annotations.dart';

import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:mockito/mockito.dart';

import '../../mapper_helper.dart';
import 'source_to_metadata_companion_mapper_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<Mapper<sources.Namespace, int>>(as: #MockNamespaceMapper),
  ],
)
void main() {
  final mockNamespaceMapper = MockNamespaceMapper();

  mapperGroup(
    name: 'SourceToMetaDataCompanionMapper',
    mapper: SourceToMetaDataCompanionMapper(mockNamespaceMapper),
    test: (mapper) {
      mapperTest(
        'sources.MetaData',
        'MetaDatasCompanion',
        from: sources.MetaData('subject', 'tvalue', {}),
        to: const MetaDatasCompanion(
          name: Value('subject'),
          value: Value('tvalue'),
          namespaceId: Value(NamespaceSeed.dc),
          others: Value(null),
        ),
        stub: () {
          when(mockNamespaceMapper.from(sources.Namespace.dc))
              .thenReturn(NamespaceSeed.dc);
        },
        mapper: mapper,
      );
    },
  );
}
