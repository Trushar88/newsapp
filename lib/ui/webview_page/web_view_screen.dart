import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newsapp/app/config/app_assets.dart';
import 'package:newsapp/app/config/app_strings.dart';
import 'package:newsapp/base/base_body_widget.dart';
import 'package:newsapp/common/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BaseBodyWidget(
      child: Scaffold(
          appBar: const MyAppBar(
            trailList: [],
            title: APPSTRING.newsDetail,
            leadingImage: APPASSETS.ARROW_LEFT,
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    try {
      _controller = WebViewController()
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    } catch (err) {
      log(err.toString());
    }
  }
}
