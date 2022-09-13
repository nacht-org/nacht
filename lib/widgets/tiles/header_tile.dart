import 'package:flutter/material.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  final Widget title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ListTile(
      title: DefaultTextStyle(
        style: theme.textTheme.labelLarge!.copyWith(
          color: theme.colorScheme.secondary,
        ),
        child: title,
      ),
      dense: true,
    );
  }
}
