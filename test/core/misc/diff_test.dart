import 'package:chapturn/core/misc/diff.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

class MockData extends Equatable {
  final int id;
  final String value;

  const MockData(this.id, this.value);

  @override
  String toString() {
    return "$runtimeType($id, '$value')";
  }

  @override
  List<Object?> get props => [id, value];
}

void main() {
  const prevData = [
    MockData(1, 'one'),
    MockData(2, 'two'),
    MockData(3, 'three'),
    MockData(4, 'four'),
    MockData(5, 'five'),
    MockData(6, 'six'),
    MockData(7, 'seven'),
  ];

  const nextData = [
    MockData(1, 'one'),
    MockData(2, 'Two'),
    MockData(3, 'three'),
    MockData(4, 'Four'),
    MockData(5, 'five'),
    MockData(8, 'Eight'),
  ];

  test('should correctly identify changes', () {
    final changes = calculateDiff<MockData>(
      prevData,
      nextData,
      identity: (item) => item.id,
      equality: (a, b) => a.value == b.value,
    );

    const expected = [
      ChangeElement<MockData>.keep(MockData(1, 'one')),
      ChangeElement<MockData>.replace(MockData(2, 'two'), MockData(2, 'Two')),
      ChangeElement<MockData>.keep(MockData(3, 'three')),
      ChangeElement<MockData>.replace(MockData(4, 'four'), MockData(4, 'Four')),
      ChangeElement<MockData>.keep(MockData(5, 'five')),
      ChangeElement<MockData>.insert(MockData(8, 'Eight')),
      ChangeElement<MockData>.remove(MockData(6, 'six')),
      ChangeElement<MockData>.remove(MockData(7, 'seven')),
    ];

    expect(changes.length, expected.length);
    for (var i = 0; i < expected.length; i++) {
      expect(changes[i], expected[i]);
    }
  });
}
