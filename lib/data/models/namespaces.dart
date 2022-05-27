import 'package:drift/drift.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

import '../exception.dart';

class Namespaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get value => text().withLength(max: 8)();
}

abstract class NamespaceSeed {
  static const int dc = 1;
  static const int opf = 2;

  static sources.Namespace intoNamespace(int namespaceId) {
    switch (namespaceId) {
      case NamespaceSeed.dc:
        return sources.Namespace.dc;
      case NamespaceSeed.opf:
        return sources.Namespace.opf;
      default:
        throw SeedException();
    }
  }

  static int fromNamespace(sources.Namespace input) {
    switch (input) {
      case sources.Namespace.dc:
        return NamespaceSeed.dc;
      case sources.Namespace.opf:
        return NamespaceSeed.opf;
    }
  }
}
