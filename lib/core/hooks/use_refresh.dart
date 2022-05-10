import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<RefreshIndicatorState> useRefresh() {
  final key = useMemoized(() => GlobalKey<RefreshIndicatorState>());

  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      assert(key.currentState != null);
      key.currentState?.show();
    });

    return null;
  }, []);

  return key;
}
