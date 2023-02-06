import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../services/services.dart';

part 'download_list_provider.freezed.dart';

@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState({
    required Map<int, DownloadData> data,
    required List<int> order,
    required Map<int, int> chapters,
  }) = _DownloadState;

  factory DownloadState.empty() {
    return const DownloadState(
      data: {},
      order: [],
      chapters: {},
    );
  }

  DownloadData? dataFromChapterId(int chapterId) {
    final dataId = chapters[chapterId];
    if (dataId == null) return null;
    return data[dataId];
  }

  DownloadState addAndCopy(DownloadData download) {
    return copyWith(
      data: {...data, download.id: download},
      order: [...order, download.id],
      chapters: {...chapters, download.related.chapterId: download.id},
    );
  }

  const DownloadState._();
}

final downloadListProvider =
    StateNotifierProvider<DownloadListNotifier, DownloadState>(
  (ref) => DownloadListNotifier(
    ref: ref,
    state: DownloadState.empty(),
    createDownload: ref.watch(createDownloadProvider),
    getDownloads: ref.watch(getDownloadsProvider),
  ),
  name: 'DownloadListProvider',
);

class DownloadListNotifier extends StateNotifier<DownloadState>
    with LoggerMixin {
  DownloadListNotifier({
    required Ref ref,
    required DownloadState state,
    required CreateDownload createDownload,
    required GetDownloads getDownloads,
  })  : _ref = ref,
        _createDownload = createDownload,
        _getDownloads = getDownloads,
        super(state);

  final Ref _ref;
  final CreateDownload _createDownload;
  final GetDownloads _getDownloads;

  Future<void> init() async {
    final result = await _getDownloads.call();

    result.fold(
      (failure) {
        _ref
            .read(messageServiceProvider)
            .showText("Failed to read downloads from database");
      },
      (data) {
        final Map<int, DownloadData> dataMap = {};
        final List<int> order = [];
        final Map<int, int> chaptersMap = {};

        for (final download in data) {
          dataMap[download.id] = download;
          chaptersMap[download.related.chapterId] = download.id;
          order.add(download.id);
        }

        state = DownloadState(
          data: dataMap,
          order: order,
          chapters: chaptersMap,
        );
      },
    );
  }

  Future<void> add(DownloadRelatedData related) async {
    final download =
        await _createDownload.call(related.chapterId, state.order.length);

    download.fold(
      (failure) {
        _ref
            .read(messageServiceProvider)
            .showText("Failed to create new download");
      },
      (download) {
        final data = DownloadData.fromModel(download, related);
        state = state.addAndCopy(data);
        log.info(
            "added download: id=${data.id} order=${data.orderIndex} title=${related.chapterTitle}");
      },
    );
  }
}
