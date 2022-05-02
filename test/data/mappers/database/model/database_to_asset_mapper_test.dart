import 'package:chapturn/data/datasources/local/database.dart';
import 'package:chapturn/data/mapper/mapper.dart';
import 'package:chapturn/domain/entities/asset/asset_entity.dart';
import 'package:chapturn/domain/mapper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mapper_helper.dart';
import 'database_to_asset_mapper_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<Mapper<int, String>>(as: #MockSeedToMimeTypeMapper),
  ],
)
void main() {
  var mockSeedToMimeTypeMapper = MockSeedToMimeTypeMapper();

  mapperGroup(
    name: 'DatabaseToAssetMapper',
    mapper: DatabaseToAssetMapper(
      seedToMimeTypeMapper: mockSeedToMimeTypeMapper,
    ),
    test: (mapper) {
      mapperTest(
        'db.Asset',
        'AssetEntity',
        from: Asset(
          id: 6,
          url: 'https://website.com/cover/123',
          path: '/1/6.png',
          hash: 'af5c3',
          typeId: 6,
        ),
        to: AssetEntity(
          id: 6,
          url: 'https://website.com/cover/123',
          path: '/1/6.png',
          hash: 'af5c3',
          mimetype: 'image/png',
        ),
        stub: () {
          when(mockSeedToMimeTypeMapper.from(6)).thenReturn('image/png');
        },
        mapper: mapper,
      );
    },
  );
}
