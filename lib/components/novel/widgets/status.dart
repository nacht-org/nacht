import 'package:chapturn/core/core.dart';
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
    final IconData iconData;
    switch (status) {
      case NovelStatus.ongoing:
        iconData = Icons.timelapse;
        break;
      case NovelStatus.hiatus:
        iconData = Icons.stop_circle;
        break;
      case NovelStatus.completed:
        iconData = Icons.cancel;
        break;
      case NovelStatus.unknown:
        iconData = Icons.question_mark;
        break;
    }

    return Icon(
      iconData,
      size: 16,
    );
  }

  String buildStatusLabel() {
    return status.name.capitalize();
  }

  String buildSuffix() {
    return suffix != null ? ' • $suffix' : '';
  }
}
