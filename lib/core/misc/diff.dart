import 'package:freezed_annotation/freezed_annotation.dart';

part 'diff.freezed.dart';

@freezed
class ChangeElement<T> with _$ChangeElement<T> {
  const factory ChangeElement.insert(T data) = _InsertChange;
  const factory ChangeElement.remove(T data) = _RemoveChange;
  const factory ChangeElement.replace(T prev, T next) = _ReplaceChange;
  const factory ChangeElement.keep(T data) = _KeepChange;
}

typedef ChangeHistory<T> = List<ChangeElement<T>>;

/// Calculate the difference between two lists and changes
/// required to convert [prev] to [next]
ChangeHistory<T> calculateDiff<T>(
  List<T> prev,
  List<T> next, {
  dynamic Function(T item)? identity,
  bool Function(T a, T b)? equality,
}) {
  identity ??= (item) => item;
  equality ??= (a, b) => a == b;

  final changes = <ChangeElement<T>>[];

  final aMap = {for (final item in prev) identity(item): item};
  for (final nextItem in next) {
    final prevItem = aMap.remove(identity(nextItem));
    if (prevItem == null) {
      changes.add(ChangeElement.insert(nextItem));
      continue;
    }

    if (equality(prevItem, nextItem)) {
      changes.add(ChangeElement.keep(nextItem));
    } else {
      changes.add(ChangeElement.replace(prevItem, nextItem));
    }
  }

  changes.addAll(aMap.values.map(ChangeElement.remove));

  return changes;
}
