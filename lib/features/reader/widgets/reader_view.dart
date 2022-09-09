import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import 'widgets.dart';

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
      initialValue: 0,
    );

    // Controls horizontal chapter page navigation.
    final pageController = usePageController(initialPage: reader.initialIndex);

    useEffect(() {
      ref.read(toolbarProvider.notifier).setSystemUiMode(isToolbarVisible);
      return null;
    }, []);

    useEffect(() {
      isToolbarVisible ? controller.forward() : controller.reverse();
      return null;
    }, [isToolbarVisible]);

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
          appBar: AnimatedAppBar(
            controller: controller,
            child: AppBar(
              title: Text(
                reader.novel.title,
                style: theme.textTheme.titleLarge,
                maxLines: 1,
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(36.0),
                child: ListTile(
                  title: Text(""),
                  trailing: Icon(Icons.book),
                  dense: true,
                ),
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
            controller: controller,
            child: ReaderBottomBar(
              info: info,
              controller: pageController,
            ),
          ),
        ),
      ),
    );
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
