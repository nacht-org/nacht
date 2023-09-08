import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';

/// Ensure that chapter list is cached until this widget is dropped.
class ChapterListShell extends ConsumerWidget {
  const ChapterListShell({
    Key? key,
    required this.id,
    required this.child,
  }) : super(key: key);

  final int id;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(chapterListFamily(id).notifier);
    return child;
  }
}
