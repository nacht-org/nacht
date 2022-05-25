import 'package:nacht/data/models/namespaces.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chapturn_sources/chapturn_sources.dart' as sources;

void main() {
  group('NamespaceSeed', () {
    final map = {
      NamespaceSeed.dc: sources.Namespace.dc,
      NamespaceSeed.opf: sources.Namespace.opf,
    };

    test(
      'fromNamespace should convert from sources.Namespace into seed id',
      () {
        for (final entry in map.entries) {
          final result = NamespaceSeed.fromNamespace(entry.value);
          expect(result, entry.key);
        }
      },
    );
    test(
      'intoNamespace should convert from seed id into sources.Namespace',
      () {
        for (final entry in map.entries) {
          final result = NamespaceSeed.intoNamespace(entry.key);
          expect(result, entry.value);
        }
      },
    );
  });
}
