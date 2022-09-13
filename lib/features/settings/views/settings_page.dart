import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

import '../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: const Text('Settings'),
            floating: true,
            forceElevated: innerBoxIsScrolled,
          ),
        ],
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
              DateFormatTile(),
            ],
          ),
        ),
      ),
    );
  }
}
