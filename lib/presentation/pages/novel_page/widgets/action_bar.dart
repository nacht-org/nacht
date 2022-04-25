import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ActionItem(
              icon: Icons.favorite,
              label: 'Add to library',
              onTap: () {},
              active: true,
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
    final textStyle = theme.textTheme.labelLarge?.copyWith(color: color);

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(label, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
