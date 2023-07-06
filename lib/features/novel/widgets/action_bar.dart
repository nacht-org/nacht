import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key? key,
    required this.input,
  }) : super(key: key);

  final NovelInput input;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final favourite = ref.watch(
                    novelFamily(input).select((novel) => novel.favourite));

                final icon =
                    favourite ? Icons.favorite : Icons.favorite_outline;
                final label = favourite ? 'In library' : 'Add to library';

                return ActionItem(
                  icon: icon,
                  label: label,
                  onTap: () =>
                      ref.read(novelFamily(input).notifier).toggleLibrary(),
                  active: favourite,
                );
              },
            ),
          ),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final novel = ref.watch(novelFamily(input));

              return ActionItem(
                icon: Icons.open_in_browser,
                label: 'WebView',
                onTap: () => context.router.push(
                  WebViewRoute(title: novel.title, initialUrl: novel.url),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.label,
    this.active = false,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        active ? theme.colorScheme.primary : theme.textTheme.labelLarge?.color;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: color,
      ),
      child: Column(
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
