import 'package:flutter/material.dart';

class CloseBackButton extends StatelessWidget {
  const CloseBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(context).pop,
    );
  }
}
