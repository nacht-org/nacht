import 'package:auto_route/auto_route.dart';
import 'package:nacht/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:nacht/features/home/home.dart';

List<Widget> buildMoreHeader(BuildContext context, bool innerBoxIsScrolled) {
  return [
    SliverAppBar(
      title: const Text('More'),
      floating: true,
      forceElevated: innerBoxIsScrolled,
    )
  ];
}

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('More'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ],
      body: DestinationTransition(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () => context.router.push(const CategoryRoute()),
            )
          ],
        ),
      ),
    );
  }
}