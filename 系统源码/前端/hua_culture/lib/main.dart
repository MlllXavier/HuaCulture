import 'package:flutter/material.dart';
import 'pages/other_pages/splash_page.dart';

void main() => runApp(HuaCulture());

class HuaCulture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '华文化',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: SplashPage(),
    );
  }
}