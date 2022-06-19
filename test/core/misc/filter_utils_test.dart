import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/core/core.dart';

class FilterBit with BinaryFilter {
  @override
  int get bit => 0x00000001;
}

void main() {
  test('should check if the filter is active', () {
    final tests = {
      0x00000000: false,
      0x00000010: false,
      0x00000001: true,
      0x00001101: true,
    };

    final bit = FilterBit();
    for (final entry in tests.entries) {
      expect(bit.isActive(entry.key), entry.value);
    }
  });

  test('should toggle the filter bit', () {
    final tests = {
      0x00000000: 0x00000001,
      0x00000010: 0x00000011,
      0x00000001: 0x00000000,
      0x00000011: 0x00000010,
    };

    final bit = FilterBit();
    for (final entry in tests.entries) {
      expect(bit.toggle(entry.key), entry.value);
    }
  });
}
