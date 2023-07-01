import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

final applicationLoadedProvider = Provider.autoDispose<ApplicationLoaded>(
  (ref) => ApplicationLoaded(ref: ref),
);

class ApplicationLoaded {
  const ApplicationLoaded({
    required Ref ref,
  }) : _ref = ref;

  final Ref _ref;

  Future<void> init() async {
    _ref.read(checkNewReleaseAndRouteProvider).call(silent: true);
  }
}
