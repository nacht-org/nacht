import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../main.dart';

class SliverSearchResult extends ConsumerWidget {
  const SliverSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result =
        ref.watch(browseSearchProvider.select((search) => search.result));

    return result.when(
      none: () => const SliverToBoxAdapter(),
      error: (message) => SliverFillLoadingError(
        message: Text(message),
      ),
      http: (crawlerFactory, url) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Consumer(builder: (context, ref, child) {
            final crawler = ref.watch(crawlerFamily(crawlerFactory));

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Supported by ${crawler.meta.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    // Pop once to remove the search context
                    context.router
                        .popAndPush(NovelRoute(type: NovelType.url(url)));
                  },
                  child: const Text('Fetch'),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
