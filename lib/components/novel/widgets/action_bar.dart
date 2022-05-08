import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';
import '../provider/novel_provider.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final favourite =
                    ref.watch(novelProvider.select((novel) => novel.favourite));

                final icon =
                    favourite ? Icons.favorite : Icons.favorite_outline;
                final label = favourite ? 'In library' : 'Add to library';
                final onTap = favourite
                    ? ref.read(novelProvider.notifier).removeFromLibrary
                    : ref.read(novelProvider.notifier).addToLibrary;

                return ActionItem(
                  icon: icon,
                  label: label,
                  onTap: onTap,
                  active: favourite,
                );
              },
            ),
          ),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final novel = ref.watch(novelProvider);

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
    final color = active ? theme.colorScheme.primary : null;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: color);

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(label, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
