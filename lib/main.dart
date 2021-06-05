import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tc/pages/home/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Name",
      theme: ThemeData(brightness: Brightness.dark),
      home: Home(),
    );
  }
}
