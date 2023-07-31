import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsView extends StatefulWidget {

  String ?url ;
   NewsView({key, this.url});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final Completer<WebViewController> Controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: Container(child:WebView(initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated:(WebViewController webviewController){
        setState(() {
          Controller.complete(webviewController);
        });
      }),
    ));
  }
}