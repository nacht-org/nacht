import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({
    Key? key,
    required this.title,
    required this.initialUrl,
  }) : super(key: key);

  final String title;
  final String initialUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: initialUrl,
      ),
    );
  }
}
