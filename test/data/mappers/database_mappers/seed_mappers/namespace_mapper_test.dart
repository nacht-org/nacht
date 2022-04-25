import 'package:chapturn/data/mappers/database_mappers/seed_mappers/namespace_mapper.dart';
import 'package:chapturn/data/models/namespaces.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../../mapper_helper.dart';

void main() {
  mapperGroup(
    name: 'NamespaceToSeedMapper',
    mapper: NamespaceToSeedMapper(),
    test: (mapper) {
      mapperTest(
        'Namespace.dc',
        'NamespaceSeed.dc',
        from: Namespace.dc,
        to: NamespaceSeed.dc,
        mapper: mapper,
      );

      mapperTest(
        'Namespace.opf',
        'NamespaceSeed.opf',
        from: Namespace.opf,
        to: NamespaceSeed.opf,
        mapper: mapper,
      );
    },
  );

  mapperGroup(
    name: 'SeedToNamespaceMapper',
    mapper: SeedToNamespaceMapper(),
    test: (mapper) {
      mapperTest(
        'NamespaceSeed.dc',
        'Namespace.dc',
        from: NamespaceSeed.dc,
        to: Namespace.dc,
        mapper: mapper,
      );

      mapperTest(
        'NamespaceSeed.opf',
        'Namespace.opf',
        from: NamespaceSeed.opf,
        to: Namespace.opf,
        mapper: mapper,
      );
    },
  );
}
