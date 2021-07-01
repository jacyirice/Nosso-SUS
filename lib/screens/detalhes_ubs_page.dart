import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bottomBar.dart';

class DetalheUbsPage extends StatefulWidget {
  final linkUbs;
  DetalheUbsPage({Key? key, this.linkUbs}) : super(key: key);

  @override
  _DetalheUbsPageState createState() => _DetalheUbsPageState();
}

class _DetalheUbsPageState extends State<DetalheUbsPage> {
  @override
  initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Detalhes da unidade'),
      ),
      body: WebView(
        initialUrl: widget.linkUbs,
      ),
      bottomNavigationBar: AppBottom(
        activeBottom: 1,
      ),
    );
  }
}
