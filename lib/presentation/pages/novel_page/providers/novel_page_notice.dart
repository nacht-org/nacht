import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'novel_page_notice.freezed.dart';

@freezed
class NovelPageNotice with _$NovelPageNotice {
  factory NovelPageNotice.error(String message) = _ErrorNotice;
}

class NoticeController extends StateNotifier<NovelPageNotice?> {
  NoticeController() : super(null);

  void error(String message) {
    state = NovelPageNotice.error(message);
  }
}
