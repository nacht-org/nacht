import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/novel_page_notice.dart';
import '../providers/providers.dart';

class NoticeListener extends ConsumerWidget {
  const NoticeListener({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<NovelPageNotice?>(noticeProvider, (previous, next) {
      if (next == null) {
        return;
      }

      final snackBar = next.when(
        error: (message) => SnackBar(content: Text(message)),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    return child;
  }
}
