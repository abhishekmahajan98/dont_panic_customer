import 'package:dont_panic_customer/pages/chat_webview_page.dart';
import 'package:dont_panic_customer/pages/home_page.dart';
import 'package:dont_panic_customer/pages/offine_page.dart';
import 'package:dont_panic_customer/pages/share_location.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/offline_page': (context) => OfflinePage(),
        '/chat_webview': (context) => ChatWebview(),
        '/share_location_page': (context) => ShareLocation(),
      },
    );
  }
}
