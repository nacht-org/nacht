import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/app_router.dart';

List<Widget> buildBrowseHeader(BuildContext context, bool innerBoxIsScrolled) {
  return [
    SliverAppBar(
      title: const Text('Browse'),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: const Text('Import from url'),
                onTap: () => context.router.push(const ImportFromUrlRoute()),
              ),
            ];
          },
        ),
      ],
      floating: true,
      forceElevated: innerBoxIsScrolled,
    )
  ];
}
