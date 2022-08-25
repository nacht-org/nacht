import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import 'widgets.dart';

extension on PageController {
  double? get pageSafe {
    return hasClients ? page?.roundToDouble() : null;
  }
}

class ReaderBottomBar extends ConsumerWidget {
  const ReaderBottomBar({
    Key? key,
    required this.info,
    required this.controller,
  }) : super(key: key);

  final ReaderInfo info;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Top(
          info: info,
          controller: controller,
        ),
        const SizedBox(height: 8.0),
        const _Bottom(),
      ],
    );
  }
}

class _Top extends ConsumerWidget {
  const _Top({
    Key? key,
    required this.info,
    required this.controller,
  }) : super(key: key);

  final ReaderInfo info;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reader = ref.watch(readerFamily(info));
    final notifier = ref.watch(readerFamily(info).notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          buildRoundedMaterial(
            theme: theme,
            shape: const CircleBorder(),
            child: IconButton(
              // FIXME: doesnt update when page is changed by swiping.
              onPressed: reader.current.id != reader.novel.chapters.first.id
                  ? () {
                      controller.animateToPage(
                        reader.current.index - 1,
                        duration: kShortAnimationDuration,
                        curve: Curves.ease,
                      );
                      notifier.setCurrentIndex(reader.current.index - 1);
                    }
                  : null,
              icon: const Icon(Icons.skip_previous),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: buildRoundedMaterial(
              theme: theme,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kToolbarHeight),
              ),
              child: HookConsumer(
                builder: (context, ref, child) {
                  final current = useState(reader.current.index.toDouble());

                  useEffect(() {
                    if (controller.pageSafe != null) {
                      current.value = controller.page!.roundToDouble();
                    }
                    return null;
                  }, [controller.pageSafe]);

                  return Slider(
                    value: current.value,
                    min: 0,
                    max: reader.novel.chapters.length - 1,
                    divisions: reader.novel.chapters.length,
                    onChanged: (value) => current.value = value.roundToDouble(),
                    label: reader.novel.chapters[current.value.round()].title,
                    onChangeEnd: (value) {
                      final index = value.round();
                      controller.jumpToPage(index);
                      notifier.setCurrentIndex(index);
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          buildRoundedMaterial(
            theme: theme,
            shape: const CircleBorder(),
            child: IconButton(
              onPressed: reader.current.id != reader.novel.chapters.last.id
                  ? () {
                      controller.animateToPage(
                        reader.current.index + 1,
                        duration: kShortAnimationDuration,
                        curve: Curves.ease,
                      );
                      notifier.setCurrentIndex(reader.current.index + 1);
                    }
                  : null,
              icon: const Icon(Icons.skip_next),
            ),
          ),
        ],
      ),
    );
  }

  Material buildRoundedMaterial({
    required ThemeData theme,
    required ShapeBorder shape,
    required Widget child,
  }) {
    return Material(
      color: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      elevation: 4.0,
      shape: shape,
      child: child,
    );
  }
}

class _Bottom extends ConsumerWidget {
  const _Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(readerPreferencesProvider.notifier);

    return CustomBottomBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final colorMode = ref.watch(
                  readerPreferencesProvider.select((value) => value.colorMode));

              return PopupMenuButton<ReaderColorMode>(
                tooltip: 'Color mode',
                initialValue: colorMode,
                itemBuilder: (context) => ReaderColorMode.values
                    .map(
                      (mode) =>
                          PopupMenuItem(value: mode, child: Text(mode.name)),
                    )
                    .toList(),
                onSelected: notifier.setColorMode,
                icon: const Icon(Icons.style),
              );
            },
          ),
          Consumer(builder: (context, ref, child) {
            final fontFamily = ref.watch(
                readerPreferencesProvider.select((value) => value.fontFamily));

            return PopupMenuButton<ReaderFontFamily>(
              tooltip: 'Font family',
              initialValue: fontFamily,
              itemBuilder: (context) => ReaderFontFamily.values
                  .map((font) =>
                      PopupMenuItem(value: font, child: Text(font.name)))
                  .toList(),
              onSelected: notifier.setFontFamily,
              icon: const Icon(Icons.font_download),
            );
          }),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => showExpandableBottomSheet(
              context: context,
              builder: (context, scrollController) {
                return SettingsSheet(
                  controller: scrollController,
                );
              },
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
