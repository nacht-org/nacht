import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';

import '../models/models.dart';
import '../services/services.dart';

part 'download_list_provider.freezed.dart';

@freezed
class DownloadListState with _$DownloadListState {
  const factory DownloadListState({
    required Map<int, DownloadData> data,
    required List<int> order,
    required Map<int, int> chapters,
  }) = _DownloadListState;

  factory DownloadListState.empty() {
    return const DownloadListState(
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

  DownloadListState addAndCopy(DownloadData download) {
    return copyWith(
      data: {...data, download.id: download},
      order: [...order, download.id],
      chapters: {...chapters, download.related.chapterId: download.id},
    );
  }

  DownloadListState copyWithoutId(int id) {
    return copyWith(
      data: {
        for (final entry in data.entries)
          if (entry.key != id) entry.key: entry.value
      },
      order: order.where((value) => value != id).toList(),
      chapters: {
        for (final entry in chapters.entries)
          if (entry.key != id) entry.key: entry.value
      },
    );
  }

  DownloadData? get first {
    if (order.isEmpty) return null;
    return data[order.first];
  }

  const DownloadListState._();
}

final downloadListProvider =
    StateNotifierProvider<DownloadListNotifier, DownloadListState>(
  (ref) => DownloadListNotifier(
    ref: ref,
    state: DownloadListState.empty(),
    createDownload: ref.watch(createDownloadProvider),
    getDownloads: ref.watch(getDownloadsProvider),
    removeDownload: ref.watch(removeDownloadProvider),
  ),
  name: 'DownloadListProvider',
);

class DownloadListNotifier extends StateNotifier<DownloadListState>
    with LoggerMixin {
  DownloadListNotifier({
    required Ref ref,
    required DownloadListState state,
    required CreateDownload createDownload,
    required GetDownloads getDownloads,
    required RemoveDownload removeDownload,
  })  : _ref = ref,
        _createDownload = createDownload,
        _getDownloads = getDownloads,
        _removeDownload = removeDownload,
        super(state);

  final Ref _ref;
  final CreateDownload _createDownload;
  final GetDownloads _getDownloads;
  final RemoveDownload _removeDownload;

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

        state = DownloadListState(
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

  Future<void> remove(int downloadId) async {
    final result = await _removeDownload.call(downloadId);

    result.fold(
      (failure) {
        log.warning(failure);
      },
      (_) {
        state = state.copyWithoutId(downloadId);
      },
    );
  }
}
