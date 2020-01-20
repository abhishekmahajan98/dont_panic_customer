import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../constants.dart';

class ChatWebview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Offline'),
        centerTitle: true,
      ),
      body: WebviewScaffold(
        url: 'http://10.10.10.1/',
      ),
    );
  }
}
