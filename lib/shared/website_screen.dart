import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsiteScreen extends StatefulWidget {
  final String title;
  final String url;
  WebsiteScreen({
    this.title,
    this.url,
  });
  @override
  _WebsiteScreenState createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: Stack(
        children: [
          WebView(
            onPageFinished: (_) {
              setState(() {
                isloading = false;
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
          ),
          isloading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }
}
