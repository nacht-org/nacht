import 'package:chapturn/presentation/controllers/browse_notifier.dart';
import 'package:chapturn/utils/iso_lang.dart';
import 'package:chapturn/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final factories = ref.watch(availableCrawlers);

        return ListView.builder(
          itemCount: factories.length,
          itemBuilder: (context, index) {
            final meta = factories[index].meta();

            final lang =
                langFromCode(meta.lang)?['name'] ?? meta.lang.capitalize();

            return ListTile(
              title: Text(meta.name),
              subtitle: Text(lang),
              trailing: TextButton(
                child: const Text('Latest'),
                onPressed: () {},
              ),
              onTap: () {},
            );
          },
        );
      }),
    );
  }
}
