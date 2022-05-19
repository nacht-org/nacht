import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void usePostFrameCallback(void Function(Duration timeStamp) callback) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback(callback);
    return null;
  });
}
