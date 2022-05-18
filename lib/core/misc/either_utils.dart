import 'package:dartz/dartz.dart';

extension CollapseSide<L, R> on Either<L, R> {
  L get left {
    return fold(
      (l) => l,
      (r) => throw TypeError(),
    );
  }

  L? maybeLeft() => fold((l) => l, (r) => null);

  R get right {
    return fold(
      (l) => throw TypeError(),
      (r) => r,
    );
  }

  R? maybeRight() => fold((l) => null, (r) => r);
}
