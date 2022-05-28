import 'package:nacht/components/novel/novel_page.dart';
import 'package:nacht/components/novel/provider/intermediate_provider.dart';
import 'package:nacht/nht/nht.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/novel/partial_novel_data.dart';
import '../model/head_info.dart';
import 'novel_head.dart';

class PartialView extends HookWidget {
  const PartialView({
    Key? key,
    required this.head,
    required this.either,
    required this.novel,
  }) : super(key: key);

  final HeadInfo head;
  final NovelEither either;
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
            return RefreshIndicator(
              onRefresh: ref.read(intermediateProvider(either).notifier).reload,
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
                sliver: NovelHead(head: head),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
