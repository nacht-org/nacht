import 'package:flutter/material.dart';

class StepListTile extends StatelessWidget {
  const StepListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.increment,
    required this.decrement,
  }) : super(key: key);

  final Widget title;
  final Widget subtitle;
  final Widget increment;
  final Widget decrement;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          decrement,
          increment,
        ],
      ),
    );
  }
}
