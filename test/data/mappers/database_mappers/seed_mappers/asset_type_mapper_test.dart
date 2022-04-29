import 'package:chapturn/data/mappers/database_mappers/seed_mappers/asset_type_mapper.dart';

import '../../mapper_helper.dart';

void main() {
  mapperGroup(
    name: 'MimeTypeToSeedMapper',
    mapper: MimeTypeToSeedMapper(),
    test: (mapper) {
      mapperTest('image/apng', '1', from: 'image/apng', to: 1, mapper: mapper);
      mapperTest('image/avif', '2', from: 'image/avif', to: 2, mapper: mapper);
      mapperTest('image/gif', '3', from: 'image/gif', to: 3, mapper: mapper);
      mapperTest('image/jpeg', '4', from: 'image/jpeg', to: 4, mapper: mapper);
      mapperTest('image/png', '5', from: 'image/png', to: 5, mapper: mapper);
      mapperTest('image/svg+xml', '6',
          from: 'image/svg+xml', to: 6, mapper: mapper);
      mapperTest('image/webp', '7', from: 'image/webp', to: 7, mapper: mapper);
    },
  );

  mapperGroup(
      name: 'SeedToMimeTypeMapper',
      mapper: SeedToMimeTypeMapper(),
      test: (mapper) {
        mapperTest('1', 'image/apng',
            from: 1, to: 'image/apng', mapper: mapper);
        mapperTest('2', 'image/avif',
            from: 2, to: 'image/avif', mapper: mapper);
        mapperTest('3', 'image/gif', from: 3, to: 'image/gif', mapper: mapper);
        mapperTest('4', 'image/jpeg',
            from: 4, to: 'image/jpeg', mapper: mapper);
        mapperTest('5', 'image/png', from: 5, to: 'image/png', mapper: mapper);
        mapperTest('6', 'image/svg+xml',
            from: 6, to: 'image/svg+xml', mapper: mapper);
        mapperTest('7', 'image/webp',
            from: 7, to: 'image/webp', mapper: mapper);
      });
}
