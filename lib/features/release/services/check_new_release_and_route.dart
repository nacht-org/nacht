import 'package:dartz/dartz.dart';
import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';

import 'check_new_release.dart';

final checkNewReleaseAndRouteProvider = Provider.autoDispose(
  (ref) => CheckNewReleaseAndRoute(
    ref: ref,
    checkNewRelease: ref.watch(checkNewReleaseProvider),
  ),
);

class CheckNewReleaseAndRoute {
  const CheckNewReleaseAndRoute({
    required Ref ref,
    required CheckNewRelease checkNewRelease,
  })  : _ref = ref,
        _checkNewRelease = checkNewRelease;

  final Ref _ref;
  final CheckNewRelease _checkNewRelease;

  Future<Either<Failure, void>> call() async {
    final result = await _checkNewRelease.call();
    return result.fold(
      (failure) => Left(failure),
      (release) {
        if (release != null) {
          _ref.read(routerProvider).push(NewReleaseRoute(release: release));
        }
        return const Right(null);
      },
    );
  }
}
