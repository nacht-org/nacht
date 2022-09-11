import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';

final refreshProvider = StateNotifierProvider<RefreshNotifier, bool>(
  (ref) => RefreshNotifier(
    read: ref.read,
    refreshNovels: ref.watch(refreshNovelsProvider),
  ),
  name: "RefreshProvider",
);

class RefreshNotifier extends StateNotifier<bool> with LoggerMixin {
  RefreshNotifier({
    required Reader read,
    required RefreshNovels refreshNovels,
  })  : _read = read,
        _refreshNovels = refreshNovels,
        super(false);

  final Reader _read;
  final RefreshNovels _refreshNovels;

  Future<void> refreshAll() async {
    if (_isBusy) {
      _showBusy();
      return;
    }

    // Set status to busy.
    state = true;

    try {
      final failures = await _refreshNovels.execute();

      if (failures.isEmpty) {
        return;
      }

      for (final entry in failures.entries) {
        log.warning(
          "Failed to update ${entry.key.id}: '${entry.key.title}' with '${entry.value}'",
        );
      }

      _messageService.showText("Failed to update ${failures.length} novels");
    } catch (e) {
      _messageService.showText("Encountered unexpected error");
      log.warning(e);
    }

    // Set status to available.
    state = false;
  }

  /// Indicates whether refresh notifier is busy
  bool get _isBusy => state;

  /// Shorthand to get message service
  MessageService get _messageService => _read(messageServiceProvider);

  /// Show busy message text
  void _showBusy() {
    _messageService.showText("An update already in progress");
  }
}
