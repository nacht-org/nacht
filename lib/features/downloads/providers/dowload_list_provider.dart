import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/downloads/services/create_download.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';

part 'dowload_list_provider.freezed.dart';

@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState({
    required Map<int, DownloadData> data,
    required List<int> order,
  }) = _DownloadState;

  const DownloadState._();
}

final downloadListProvider =
    StateNotifierProvider<DownloadListNotifier, DownloadState>(
  (ref) => DownloadListNotifier(
    ref: ref,
    state: const DownloadState(
      data: {},
      order: [],
    ),
    createDownload: ref.watch(createDownloadProvider),
  ),
  name: 'DownloadListProvider',
);

class DownloadListNotifier extends StateNotifier<DownloadState> {
  DownloadListNotifier({
    required Ref ref,
    required DownloadState state,
    required CreateDownload createDownload,
  })  : _ref = ref,
        _createDownload = createDownload,
        super(state);

  final Ref _ref;
  final CreateDownload _createDownload;

  Future<void> add(ChapterData chapter) async {
    final download = await _createDownload.call(chapter.id, state.order.length);

    download.fold(
      (failure) {
        _ref
            .read(messageServiceProvider)
            .showText("Failed to create new download");
      },
      (download) {
        final data = DownloadData.fromModel(download, chapter);

        state = state.copyWith(
          data: {...state.data, data.id: data},
          order: [...state.order, data.id],
        );
      },
    );
  }
}
