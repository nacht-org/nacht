import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/reader/provider/reader_provider.dart';
import 'package:nacht/components/reader/widgets/reader_bottom_bar.dart';
import 'package:nacht/components/widgets/animated_bottom_bar.dart';
import 'package:nacht/core/core.dart';

import '../model/reader_info.dart';
import '../provider/toolbar_provider.dart';

import 'reader_body.dart';

class ReaderView extends HookConsumerWidget {
  const ReaderView({
    Key? key,
    required this.info,
  }) : super(key: key);

  final ReaderInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reader = ref.watch(readerProvider(info));

    final isToolbarVisible =
        ref.watch(toolbarProvider.select((toolbar) => toolbar.visible));

    final controller = useAnimationController(
      duration: kShortAnimationDuration,
      initialValue: 1,
    );

    useEffect(() {
      ref.read(toolbarProvider.notifier).setSystemUiMode(isToolbarVisible);
      return null;
    }, []);

    return WillPopScope(
      onWillPop: () async {
        // Make sure status bar is visible when exiting reader
        ref.read(toolbarProvider.notifier).setSystemUiMode(true);
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: SlidingPrefferedSize(
          controller: controller,
          visible: isToolbarVisible,
          child: AppBar(
            title: Consumer(builder: (context, ref, child) {
              final current = ref
                  .watch(readerProvider(info).select((value) => value.current));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reader.novel.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.appBarTheme.foregroundColor,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    current.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                    maxLines: 1,
                  ),
                ],
              );
            }),
          ),
        ),
        body: ReaderBody(reader: reader),
        extendBody: true,
        bottomNavigationBar: AnimatedBottomBar(
          visible: isToolbarVisible,
          child: const ReaderBottomBar(),
        ),
      ),
    );
  }
}
