import 'package:chapturn/data/exception.dart';
import 'package:chapturn/data/models/models.dart';
import 'package:chapturn_sources/chapturn_sources.dart';

import '../../../../domain/mapper.dart';

class NamespaceToSeedMapper implements Mapper<Namespace, int> {
  @override
  int from(Namespace input) {
    switch (input) {
      case Namespace.dc:
        return NamespaceSeed.dc;
      case Namespace.opf:
        return NamespaceSeed.opf;
    }
  }
}

class SeedToNamespaceMapper implements Mapper<int, Namespace> {
  @override
  Namespace from(int input) {
    switch (input) {
      case NamespaceSeed.dc:
        return Namespace.dc;
      case NamespaceSeed.opf:
        return Namespace.opf;
      default:
        throw SeedException();
    }
  }
}
