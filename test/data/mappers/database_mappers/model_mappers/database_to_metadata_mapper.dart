import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mappers/database_mappers/model_mappers/database_to_metadata_mapper.dart';
import 'package:chapturn/data/models/models.dart';
import 'package:chapturn/domain/entities/novel/metadata_entity.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;
import 'package:mockito/annotations.dart';

import '../../mapper_helper.dart';
import 'database_to_metadata_mapper.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<Mapper<int, sources.Namespace>>(as: #MockSeedToNamespaceMapper),
  ],
)
void main() {
  final mockNamespaceMapper = MockSeedToNamespaceMapper();

  mapperGroup(
    name: 'DatabaseToMetaDataMapper',
    mapper: DatabaseToMetaDataMapper(mockNamespaceMapper),
    test: (mapper) {
      mapperTest(
        'db.MetaData',
        'MetaDataEntity',
        from: MetaData(
          id: 6,
          name: 'subject',
          value: 'tvalue',
          namespaceId: NamespaceSeed.opf,
          others: '{"href":"https://website.com/link"}',
          novelId: 2,
        ),
        to: MetaDataEntity(
          id: 6,
          name: 'subject',
          value: 'tvalue',
          namespace: sources.Namespace.opf,
          others: {'href': 'https://website.com/link'},
          novelId: 2,
        ),
        mapper: mapper,
      );
    },
  );
}
