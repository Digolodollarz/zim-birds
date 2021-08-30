import 'package:flutter/material.dart';
import 'package:zim_birds/src/home_page.dart';
import 'package:zim_birds/src/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zim Birds',
      theme: appTheme(),
      home: HomePage(),
    );
  }
}
