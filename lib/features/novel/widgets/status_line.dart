import 'package:material_symbols_icons/symbols.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:flutter/material.dart';

class StatusLine extends StatelessWidget {
  const StatusLine({
    Key? key,
    required this.status,
    this.suffix,
  }) : super(key: key);

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
    final iconData = switch (status) {
      NovelStatus.ongoing => Symbols.timelapse,
      NovelStatus.hiatus => Symbols.pause,
      NovelStatus.completed => Symbols.check,
      NovelStatus.stub => Symbols.cut,
      NovelStatus.dropped => Symbols.cancel,
      NovelStatus.unknown => Symbols.question_mark,
    };

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
