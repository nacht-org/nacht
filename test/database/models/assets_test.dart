import 'package:nacht/database/database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AssetTypeSeed', () {
    final mimeTypeMap = {
      1: 'image/apng',
      2: 'image/avif',
      3: 'image/gif',
      4: 'image/jpeg',
      5: 'image/png',
      6: 'image/svg+xml',
      7: 'image/webp',
      8: 'text/html',
      9: 'text/css',
    };

    test('fromMimeType should convert mimetype into seed id', () {
      for (final entry in mimeTypeMap.entries) {
        final result = AssetTypeSeed.fromMimeType(entry.value);
        expect(result, entry.key);
      }
    });

    test('intoMimeType should convert seed id into mimetype', () {
      for (final entry in mimeTypeMap.entries) {
        final result = AssetTypeSeed.intoMimeType(entry.key);
        expect(result, entry.value);
      }
    });
  });
}
