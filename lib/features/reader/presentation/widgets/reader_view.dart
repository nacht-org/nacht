import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../presentation.dart';

class ReaderView extends HookConsumerWidget {
  const ReaderView({
    Key? key,
    required this.info,
  }) : super(key: key);

  final ReaderInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reader = ref.watch(readerFamily(info));
    final backgroundColor = ref.watch(readerPreferencesProvider.select(
      (pref) => pref.colorMode.value?.backgroundColor,
    ));

    final isToolbarVisible =
        ref.watch(toolbarProvider.select((toolbar) => toolbar.visible));

    // Controls appbar animation.
    final controller = useAnimationController(
      duration: kShortAnimationDuration,
      initialValue: 1,
    );

    // Controls horizontal chapter page navigation.
    final pageController = usePageController(initialPage: reader.initialIndex);

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
      child: ExpandableSheetOverride(
        mediaQuery: MediaQuery.of(context),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: SlidingPrefferedSize(
            controller: controller,
            visible: isToolbarVisible,
            child: ReaderAppBar(
              // FIXME: overflows to two lines.
              title: Text(
                reader.novel.title,
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          backgroundColor: backgroundColor,
          body: ReaderBody(
            reader: reader,
            controller: pageController,
          ),
          // FIXME: does not work as intended.
          extendBody: true,
          bottomNavigationBar: AnimatedBottomBar(
            visible: isToolbarVisible,
            child: ReaderBottomBar(
              info: info,
              controller: pageController,
            ),
          ),
        ),
      ),
    );
  }

  /// Reader title with novel title and chapter title
  ///
  /// Note: Use was deprecated because it looked cramped.
  /// Code remains unremoved until another solution to display
  /// chapter title is implemented.
  ///
  /// TODO: implement another solution to display chapter title.
  /// TODO: remove this method and the code block.
  Consumer buildTitle(ReaderInfo reader, ThemeData theme) {
    return Consumer(builder: (context, ref, child) {
      final current =
          ref.watch(readerFamily(info).select((value) => value.current));

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
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
    });
  }
}

class ReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReaderAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final Widget title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Material(
      color: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.only(top: mediaQuery.padding.top),
        child: NavigationToolbar(
          leading: const BackButton(),
          middle: title,
          centerMiddle: false,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
