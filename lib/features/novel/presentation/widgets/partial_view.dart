import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/nht/nht.dart';

import '../presentation.dart';

class PartialView extends HookWidget {
  const PartialView({
    Key? key,
    required this.novel,
  }) : super(key: key);

  final PartialNovelData novel;

  @override
  Widget build(BuildContext context) {
    final refreshKey = useRefresh();

    return Scaffold(
      body: NestedScrollView(
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
            final notifier = ref.watch(intermediateProvider(novel).notifier);

            return RefreshIndicator(
              onRefresh: notifier.reload,
              key: refreshKey,
              child: child!,
            );
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 24.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                sliver: NovelHead(
                  head: HeadInfo.fromPartial(novel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
