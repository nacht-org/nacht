import 'package:chapturn/utils/string.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';

class StatusInfo extends StatelessWidget {
  const StatusInfo({Key? key, required this.status, this.suffix})
      : super(key: key);

  final NovelStatus status;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildIcon(),
        const SizedBox(width: 4.0),
        Text(
          buildStatusLabel() + buildSuffix(),
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget buildIcon() {
    switch (status) {
      case NovelStatus.ongoing:
        return const Icon(Icons.timelapse);
      case NovelStatus.hiatus:
        return const Icon(Icons.stop_circle);
      case NovelStatus.completed:
        return const Icon(Icons.cancel);
      case NovelStatus.unknown:
        return const Icon(Icons.question_mark);
    }
  }

  String buildStatusLabel() {
    return status.name.capitalize();
  }

  String buildSuffix() {
    return suffix != null ? ' • $suffix' : '';
  }
}
