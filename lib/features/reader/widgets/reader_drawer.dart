import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/reader/models/models.dart';
import 'package:nacht/shared/novel/providers/chapter_list_family.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ReaderDrawer extends ConsumerWidget {
  const ReaderDrawer({
    Key? key,
    required this.reader,
    required this.pageController,
    required this.itemScrollController,
    required this.itemPositionsListener,
  }) : super(key: key);

  final ReaderInfo reader;
  final PageController pageController;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Contents"),
        ),
        body: SafeArea(
          bottom: false,
          child: DrawerBody(
            reader: reader,
            pageController: pageController,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          ),
        ),
      ),
    );
  }
}

class DrawerBody extends HookConsumerWidget {
  const DrawerBody({
    Key? key,
    required this.reader,
    required this.pageController,
    required this.itemScrollController,
    required this.itemPositionsListener,
  }) : super(key: key);

  final ReaderInfo reader;
  final PageController pageController;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final chapterList = ref.watch(chapterListFamily(reader.novel.id));
    final dateFormatService = ref.watch(dateFormatServiceFamily(locale));

    return Scrollbar(
      child: ScrollablePositionedList.builder(
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              chapterList.chapters[index].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: chapterList.chapters[index].updated == null
                ? null
                : Text(
                    dateFormatService
                        .relativeDay(chapterList.chapters[index].updated!),
                  ),
            onTap: () {
              pageController.jumpToPage(index);
              Navigator.of(context).pop();
            },
            selected: index == reader.index,
            dense: true,
          );
        },
        itemCount: chapterList.chapters.length,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        initialScrollIndex: reader.index,
      ),
    );
  }
}
