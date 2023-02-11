import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/nacht_theme/nacht_theme.dart';

import '../providers/providers.dart';
import 'shaded_expansion/shaded_expansion.dart';

class DescriptionAndTags extends HookWidget {
  const DescriptionAndTags({
    super.key,
    required this.description,
    required this.novelId,
    required this.initialExpanded,
  });

  final List<String> description;
  final int novelId;
  final bool initialExpanded;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(initialExpanded);

    return GestureDetector(
      onTap: () => expanded.value = !expanded.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Description(description: description, expanded: expanded),
          _Tags(novelId: novelId, expanded: expanded)
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.description,
    required this.expanded,
  }) : super(key: key);

  final List<String> description;
  final ValueNotifier<bool> expanded;

  @override
  Widget build(BuildContext context) {
    final paragraphs =
        description.isEmpty ? ["No description provided"] : description;

    return AnimatedShadedExpansion(
      open: expanded.value,
      duration: kShortAnimationDuration,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          key: Key("description-${description.hashCode}"),
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(paragraphs.first),
              for (final paragraph in paragraphs.skip(1)) ...[
                const SizedBox(height: 4.0),
                Text(paragraph),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Tags extends ConsumerWidget {
  const _Tags({
    Key? key,
    required this.novelId,
    required this.expanded,
  }) : super(key: key);

  final int novelId;
  final ValueNotifier<bool> expanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(tagsStreamFamily(novelId));

    final children = data.whenOrNull(
          data: (tags) => <Widget>[
            for (final tag in tags)
              Chip(
                label: Text(
                  tag.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ) ??
        [];

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedCrossFade(
      crossFadeState:
          expanded.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Wrap(
          spacing: 8.0,
          children: children,
        ),
      ),
      secondChild: Align(
        alignment: AlignmentDirectional.centerStart,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              children.first,
              for (final chip in children.skip(1)) ...[
                const SizedBox(width: 8.0),
                chip,
              ],
            ],
          ),
        ),
      ),
      duration: kShortAnimationDuration,
      firstCurve: Curves.easeInOut,
      secondCurve: Curves.easeInOut,
      sizeCurve: Curves.easeInOut,
    );
  }
}
