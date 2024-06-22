import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowFile extends StatelessWidget {
  final String url;
  const ShowFile({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl:
        url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
