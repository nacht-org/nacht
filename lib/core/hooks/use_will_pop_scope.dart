import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useWillPopScope(WillPopCallback onWillPop) {}

class _WillPopHook extends Hook<void> {
  const _WillPopHook({required this.onWillPop});

  final WillPopCallback onWillPop;

  @override
  _WillPopHookState createState() => _WillPopHookState();
}

class _WillPopHookState extends HookState<void, _WillPopHook> {
  @override
  void initHook() {
    super.initHook();
    ModalRoute.of(context)?.addScopedWillPopCallback(hook.onWillPop);
  }

  @override
  void build(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
    ModalRoute.of(context)?.removeScopedWillPopCallback(hook.onWillPop);
  }
}
