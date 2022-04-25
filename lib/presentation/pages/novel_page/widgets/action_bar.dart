import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/providers.dart';

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
                final favorite = ref.watch(favoriteProvider);

                final icon = favorite ? Icons.favorite : Icons.favorite_outline;
                final label = favorite ? 'In library' : 'Add to library';

                return ActionItem(
                  icon: icon,
                  label: label,
                  onTap: () {},
                  active: favorite,
                );
              },
            ),
          ),
          Expanded(
            child: ActionItem(
              icon: Icons.open_in_browser,
              label: 'WebView',
              onTap: () {},
            ),
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
      borderRadius: const BorderRadius.all(Radius.circular(16)),
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
