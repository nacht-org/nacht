import 'package:nacht/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('capitalize', () {
    test('should return unmodified when string is empty', () {
      const string = '';
      final result = string.capitalize();
      expect(result, string);
    });

    test('should convert to uppercase when length is 1', () {
      const string = 'a';
      final result = string.capitalize();
      expect(result, 'A');
    });

    test(
        'should convert first character to uppercase when length is greater than 1',
        () {
      const string = 'lorem';
      final result = string.capitalize();
      expect(result, 'Lorem');
    });
  });
}
