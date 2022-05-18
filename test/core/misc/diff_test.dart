import 'package:chapturn/core/misc/diff_utils.dart';
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
  final prevData = IdentityList<MockData, int>(
    items: const [
      MockData(1, 'one'),
      MockData(2, 'two'),
      MockData(3, 'three'),
      MockData(4, 'four'),
      MockData(5, 'five'),
      MockData(6, 'six'),
      MockData(7, 'seven'),
    ],
    identity: (item) => item.id,
  );

  final nextData = IdentityList<MockData, int>(
    items: const [
      MockData(1, 'one'),
      MockData(2, 'Two'),
      MockData(3, 'three'),
      MockData(4, 'Four'),
      MockData(5, 'five'),
      MockData(8, 'Eight'),
    ],
    identity: (item) => item.id,
  );

  test('should correctly identify changes', () {
    final changes = calculateDiff<MockData, MockData>(
      prev: prevData,
      next: nextData,
      equality: (a, b) => a.value == b.value,
    ).toList();

    const expected = <ChangeElement>[
      ChangeElement<MockData, MockData>.keep(
          MockData(1, 'one'), MockData(1, 'one')),
      ChangeElement<MockData, MockData>.replace(
          MockData(2, 'two'), MockData(2, 'Two')),
      ChangeElement<MockData, MockData>.keep(
          MockData(3, 'three'), MockData(3, 'three')),
      ChangeElement<MockData, MockData>.replace(
          MockData(4, 'four'), MockData(4, 'Four')),
      ChangeElement<MockData, MockData>.keep(
          MockData(5, 'five'), MockData(5, 'five')),
      ChangeElement<MockData, MockData>.insert(MockData(8, 'Eight')),
      ChangeElement<MockData, MockData>.remove(MockData(6, 'six')),
      ChangeElement<MockData, MockData>.remove(MockData(7, 'seven')),
    ];

    expect(changes.length, expected.length);
    for (var i = 0; i < expected.length; i++) {
      expect(changes[i], expected[i]);
    }
  });
}
