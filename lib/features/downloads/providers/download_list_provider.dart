import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';
import '../services/services.dart';
import 'providers.dart';

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

  DownloadListState copyWithData(DownloadData download) {
    return copyWith(
      data: {...data, download.id: download},
      order: [...order, download.id],
      chapters: {...chapters, download.related.chapterId: download.id},
    );
  }

  DownloadListState copyWithMany(Iterable<DownloadData> downloads) {
    return copyWith(
      data: {...data, for (final download in downloads) download.id: download},
      order: [...order, for (final download in downloads) download.id],
      chapters: {
        ...chapters,
        for (final download in downloads)
          download.related.chapterId: download.id
      },
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
    insertDownload: ref.watch(insertDownloadProvider),
    getDownloads: ref.watch(getDownloadsProvider),
    removeDownload: ref.watch(removeDownloadProvider),
    removeAllDownloads: ref.watch(removeAllDownloadsProvider),
    insertMultipleDownloads: ref.watch(insertMultipleDownloadsProvider),
  ),
  name: 'DownloadListProvider',
);

class DownloadListNotifier extends StateNotifier<DownloadListState>
    with LoggerMixin {
  DownloadListNotifier({
    required Ref ref,
    required DownloadListState state,
    required InsertDownload insertDownload,
    required GetDownloads getDownloads,
    required RemoveDownload removeDownload,
    required RemoveAllDownloads removeAllDownloads,
    required InsertMultipleDownloads insertMultipleDownloads,
  })  : _ref = ref,
        _insertDownload = insertDownload,
        _getDownloads = getDownloads,
        _removeDownload = removeDownload,
        _removeAllDownloads = removeAllDownloads,
        _insertMultipleDownloads = insertMultipleDownloads,
        super(state);

  final Ref _ref;
  final InsertDownload _insertDownload;
  final GetDownloads _getDownloads;
  final RemoveDownload _removeDownload;
  final RemoveAllDownloads _removeAllDownloads;
  final InsertMultipleDownloads _insertMultipleDownloads;

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
    if (state.chapters.containsKey(related.chapterId)) {
      log.fine("Chapter download skipped as its already in download queue");
      return;
    }

    final download =
        await _insertDownload.call(related.chapterId, state.order.length);

    download.fold(
      (failure) {
        _ref
            .read(messageServiceProvider)
            .showText("Failed to create new download");
      },
      (download) {
        final data = DownloadData.fromModel(download, related);

        final previousState = state;
        state = state.copyWithData(data);
        log.info(
            "added download: id=${data.id} order=${data.orderIndex} title=${related.chapterTitle}");

        _onAdded(previousState);
      },
    );
  }

  Future<void> addMany(Iterable<DownloadRelatedData> relatedData) async {
    // Must filter out those that are already in the download queue
    relatedData =
        relatedData.where((r) => !state.chapters.containsKey(r.chapterId));

    final downloads =
        await _insertMultipleDownloads.call(relatedData, state.order.length);

    downloads.fold(
      (failure) {
        log.warning(failure);
        _ref.read(messageServiceProvider).showText(failure.message);
      },
      (downloads) {
        final previousState = state;
        state = state.copyWithMany(downloads);
        log.info("added ${downloads.length} downloads");
        _onAdded(previousState);
      },
    );
  }

  Future<void> remove(int downloadId) async {
    final result = await _removeDownload.call(downloadId);

    result.fold(
      (failure) {
        log.warning(failure);
        _ref.read(messageServiceProvider).showText(failure.message);
      },
      (_) {
        state = state.copyWithoutId(downloadId);
      },
    );
  }

  Future<void> removeAll() async {
    await _removeAllDownloads.call();
    state = DownloadListState.empty();
  }

  Future<void> _onAdded(DownloadListState previousState) async {
    if (previousState.order.isEmpty) {
      _ref.read(downloadProvider.notifier).setRunning(true);
      log.info("Download started when items added to empty list");
    }
  }
}
