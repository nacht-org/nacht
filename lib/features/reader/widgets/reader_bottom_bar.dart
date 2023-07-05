import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../models/models.dart';
import 'widgets.dart';

class ReaderBottomBar extends StatelessWidget {
  const ReaderBottomBar({
    Key? key,
    required this.reader,
    required this.controller,
  }) : super(key: key);

  final ReaderInfo reader;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return CustomBottomBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final isNotFirst = ref.watch(
                chapterListFamily(reader.novel.id).select((list) =>
                    list.chapters[reader.index].id != list.chapters.first.id),
              );

              return IconButton(
                tooltip: "Previous",
                onPressed: isNotFirst
                    ? () {
                        controller.animateToPage(
                          reader.index - 1,
                          duration: kShortAnimationDuration,
                          curve: Curves.ease,
                        );
                      }
                    : null,
                icon: const Icon(Icons.skip_previous),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                tooltip: "Chapter list",
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.list),
              );
            },
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => const SettingsSheet(),
            ),
            icon: const Icon(Icons.settings),
          ),
          Consumer(
            builder: (context, ref, child) {
              final isNotLast = ref.watch(
                chapterListFamily(reader.novel.id).select((list) =>
                    list.chapters[reader.index].id != list.chapters.last.id),
              );

              return IconButton(
                tooltip: "Next",
                onPressed: isNotLast
                    ? () {
                        controller.animateToPage(
                          reader.index + 1,
                          duration: kShortAnimationDuration,
                          curve: Curves.ease,
                        );
                      }
                    : null,
                icon: const Icon(Icons.skip_next),
              );
            },
          ),
        ],
      ),
    );
  }
}
