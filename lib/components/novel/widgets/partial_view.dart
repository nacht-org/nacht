import 'package:chapturn/components/novel/novel_page.dart';
import 'package:chapturn/components/novel/provider/intermediate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/novel/partial_novel_data.dart';
import 'info.dart';

class PartialView extends HookWidget {
  const PartialView({
    Key? key,
    required this.either,
    required this.novel,
  }) : super(key: key);

  final NovelEither either;
  final PartialNovelData novel;

  @override
  Widget build(BuildContext context) {
    final refreshIndicatorKey =
        useMemoized(() => GlobalKey<RefreshIndicatorState>());

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        assert(refreshIndicatorKey.currentState != null);
        refreshIndicatorKey.currentState?.show();
      });

      return null;
    }, []);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: Text(novel.title),
          floating: true,
          forceElevated: innerBoxIsScrolled,
        )
      ],
      body: Consumer(
        builder: (context, ref, child) {
          return RefreshIndicator(
            onRefresh: ref.read(intermediateProvider(either).notifier).reload,
            key: refreshIndicatorKey,
            child: child!,
          );
        },
        child: const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 24.0,
                right: 16.0,
                bottom: 16.0,
              ),
              sliver: EssentialSection(),
            ),
          ],
        ),
      ),
    );
  }
}
