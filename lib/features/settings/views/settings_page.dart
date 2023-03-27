import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

import '../widgets/widgets.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: const [
            HeaderTile(
              title: Text('Theme'),
            ),
            ThemeModeTile(),
            Divider(),
            HeaderTile(
              title: Text("Timestamps"),
            ),
            RelativeTimestampsTile(),
            DateFormatTile(),
          ],
        ),
      ),
    );
  }
}
