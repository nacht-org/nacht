import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../providers/providers.dart';

ScrollController useNavigationScrollController(NavigationNotifier notifier) {
  final controller = useScrollController();

  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifier.attach(controller);
    });

    return () => notifier.detach(controller);
  }, []);

  return controller;
}
