import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bottom_bar.dart';

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
          icon: Icon(Icons.arrow_back, color: AppColors.background),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Detalhes da unidade'),
      ),
      body: WebView(
        initialUrl: widget.linkUbs,
      ),
      bottomNavigationBar: BottomBar(
        activeBotton: 1,
      ),
    );
  }
}
