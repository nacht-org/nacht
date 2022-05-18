import 'package:freezed_annotation/freezed_annotation.dart';

part 'diff_utils.freezed.dart';

@freezed
class ChangeElement<P, N> with _$ChangeElement<P, N> {
  const factory ChangeElement.insert(N data) = _InsertChange;
  const factory ChangeElement.remove(P data) = _RemoveChange;
  const factory ChangeElement.replace(P prev, N next) = _ReplaceChange;
  const factory ChangeElement.keep(P prev, N next) = _KeepChange;
}

typedef ChangeHistory<P, N> = Iterable<ChangeElement<P, N>>;

@freezed
class IdentityList<T, I> with _$IdentityList<T, I> {
  const factory IdentityList({
    required List<T> items,
    required I Function(T item) identity,
  }) = _IdentityList;

  const IdentityList._();

  Map<I, T> toMap() {
    return {for (final item in items) identity(item): item};
  }
}

/// Calculate the difference between two lists and changes
/// required to convert [prev] to [next]
ChangeHistory<P, N> calculateDiff<P, N>({
  required IdentityList<N, dynamic> next,
  required IdentityList<P, dynamic> prev,
  bool Function(P a, N b)? equality,
}) sync* {
  equality ??= (a, b) => a == b;

  final prevMap = prev.toMap();
  for (final nextItem in next.items) {
    final prevItem = prevMap.remove(next.identity(nextItem));
    if (prevItem == null) {
      yield ChangeElement.insert(nextItem);
      continue;
    }

    if (equality(prevItem, nextItem)) {
      yield ChangeElement.keep(prevItem, nextItem);
    } else {
      yield ChangeElement.replace(prevItem, nextItem);
    }
  }

  for (final item in prevMap.values) {
    yield ChangeElement.remove(item);
  }
}
