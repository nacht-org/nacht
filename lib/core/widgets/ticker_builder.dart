import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TickerBuilder extends StatefulWidget {
  const TickerBuilder({Key? key, required this.builder}) : super(key: key);

  final Widget Function(BuildContext context, TickerProvider ticker) builder;

  @override
  State<TickerBuilder> createState() => _TickerBuilderState();
}

class _TickerBuilderState extends State<TickerBuilder>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, this);
  }
}
