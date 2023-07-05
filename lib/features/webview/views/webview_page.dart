import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
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
    final theme = Theme.of(context);

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(initialUrl));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              initialUrl,
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Refresh'),
                onTap: () => controller.reload(),
              ),
              PopupMenuItem(
                child: const Text('Share'),
                onTap: () async {
                  final url = await controller.currentUrl();
                  if (url != null) {
                    Share.share(url);
                  }
                },
              ),
              PopupMenuItem(
                child: const Text('Open in browser'),
                onTap: () async {
                  final url = await controller.currentUrl();
                  if (url != null) {
                    launchUrlString(url, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ],
          )
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
