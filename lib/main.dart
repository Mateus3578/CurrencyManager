import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tc/pages/splash/my_splash.dart';

void main() {
  //Barra de notificações no modo escuro
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tira a marca d´agua de debug
      debugShowCheckedModeBanner: false,
      // Sim, falta um nome
      title: "{insert_name}",
      // Dark mode >>>>> Light mode
      theme: ThemeData(brightness: Brightness.dark),
      home: MySplash(),
    );
  }
}
