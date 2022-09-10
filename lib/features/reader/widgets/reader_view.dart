import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
    final reader = ref.watch(readerFamily(info));
    final notifier = ref.watch(readerFamily(info).notifier);

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

    final itemScrollController = useMemoized(() => ItemScrollController());
    final itemPositionsListener =
        useMemoized(() => ItemPositionsListener.create());

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
            child: ReaderAppBar(
              reader: reader,
            ),
          ),
          backgroundColor: backgroundColor,
          body: ReaderBody(
            reader: reader,
            notifier: notifier,
            controller: pageController,
          ),
          drawer: ReaderDrawer(
            reader: reader,
            pageController: pageController,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          ),
          // FIXME: does not work as intended.
          extendBody: true,
          bottomNavigationBar: AnimatedBottomBar(
            controller: controller,
            child: ReaderBottomBar(
              reader: reader,
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
    required this.reader,
  }) : super(key: key);

  final ReaderInfo reader;

  static const double _bottomSize = 48.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(),
      title: Text(
        reader.novel.title,
        maxLines: 1,
      ),
      elevation: 8.0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(_bottomSize),
        child: Column(
          children: [
            const Divider(height: 0),
            Consumer(builder: (context, ref, consumer) {
              final chapter = ref.watch(
                chapterListFamily(reader.novel.id)
                    .select((list) => list.chapters[reader.index]),
              );

              return ListTile(
                title: Text(
                  chapter.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.book),
                dense: true,
                onTap: () => Scaffold.of(context).openDrawer(),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + _bottomSize);
}
