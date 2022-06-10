import 'package:flutter/cupertino.dart';

extension ScrollNotificationExtension on ScrollNotification {
  bool get isAtEnd => metrics.pixels == metrics.maxScrollExtent;
}
