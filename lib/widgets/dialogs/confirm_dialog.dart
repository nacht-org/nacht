import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.title,
    required this.message,
  }) : super(key: key);

  final Widget? title;
  final Widget message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: message,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
