import 'package:dartz/dartz.dart';

extension CollapseSide<L, R> on Either<L, R> {
  L? getLeft() => fold((l) => l, (r) => null);
  R? getRight() => fold((l) => null, (r) => r);
}
