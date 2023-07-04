import 'package:diffutil_dart/diffutil.dart';

class IdentityList<T, I> {
  const IdentityList({
    required this.items,
    required this.identity,
  });

  final List<T> items;
  final I Function(T item) identity;
}

class IdentityDiff<OLD, NEW, ID> implements DiffDelegate {
  const IdentityDiff({
    required this.oldList,
    required this.newList,
    required this.equality,
  });

  final IdentityList<OLD, ID> oldList;
  final IdentityList<NEW, ID> newList;
  final bool Function(OLD oldItem, NEW newItem) equality;

  @override
  bool areContentsTheSame(int oldItemPosition, int newItemPosition) {
    final oldItem = oldList.items[oldItemPosition];
    final newItem = newList.items[newItemPosition];
    return equality(oldItem, newItem);
  }

  @override
  bool areItemsTheSame(int oldItemPosition, int newItemPosition) {
    final oldItem = oldList.items[oldItemPosition];
    final newItem = newList.items[newItemPosition];
    return oldList.identity(oldItem) == newList.identity(newItem);
  }

  @override
  NEW getChangePayload(int oldItemPosition, int newItemPosition) {
    return newList.items[newItemPosition];
  }

  @override
  int getNewListSize() {
    return newList.items.length;
  }

  @override
  int getOldListSize() {
    return oldList.items.length;
  }
}
