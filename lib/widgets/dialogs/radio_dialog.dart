import 'package:flutter/material.dart';

class RadioItem<T> {
  RadioItem(this.label, this.value);

  final String label;
  final T value;
}

class RadioDialog<T> extends StatelessWidget {
  const RadioDialog({
    Key? key,
    required this.title,
    required this.items,
    required this.value,
  }) : super(key: key);

  final String title;
  final List<RadioItem<T>> items;
  final T value;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        children: items
            .map(
              (item) => RadioListTile<T>(
                value: item.value,
                groupValue: value,
                onChanged: (value) => Navigator.of(context).pop(value),
                title: Text(item.label),
                selected: item.value == value,
              ),
            )
            .toList(),
      ),
      contentPadding: const EdgeInsets.only(top: 20.0, bottom: 24.0),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
