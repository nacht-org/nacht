import 'package:flutter/material.dart';

class MenuListTileItem<T> {
  final T value;
  final String label;

  MenuListTileItem({required this.value, required this.label});
}

class MenuListTile<T> extends StatelessWidget {
  const MenuListTile({
    Key? key,
    required this.title,
    required this.active,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final MenuListTileItem active;
  final List<MenuListTileItem<T>> items;
  final void Function(T value) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(title),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                active.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.textTheme.caption?.color,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      onTap: () async {
        final overlay = Overlay.of(context)!.context.findRenderObject()!;
        final tile = context.findRenderObject() as RenderBox;

        final position = RelativeRect.fromRect(
          Rect.fromPoints(
            tile.localToGlobal(Offset(tile.size.width / 2, 0),
                ancestor: overlay),
            tile.localToGlobal(
              tile.size.topRight(Offset.zero),
              ancestor: overlay,
            ),
          ),
          Offset.zero & overlay.semanticBounds.size,
        );

        final result = await showMenu<T>(
          context: context,
          position: position,
          items: items
              .map(
                (item) => PopupMenuItem<T>(
                  value: item.value,
                  child: SizedBox(
                    width: tile.size.width / 2,
                    child: Text(item.label),
                  ),
                ),
              )
              .toList(),
          initialValue: active.value,
        );

        if (result == null) {
          return;
        }

        if (active.value != result) {
          onChanged(result);
        }
      },
    );
  }
}
