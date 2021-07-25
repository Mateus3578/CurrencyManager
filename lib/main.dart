import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tc/classes/restart_widget.dart';
import 'package:tc/views/splash/my_splash.dart';

void main() {
  //Barra de notificações transparente
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  //Função para reiniciar o app. Mais informações dentro da classe
  runApp(RestartWidget(
    child: StartApp(),
  ));
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Sim, falta um nome
      title: "{insert_name}",
      // Tira a marca d´agua de debug
      debugShowCheckedModeBanner: false,
      home: MySplash(),
    );
  }
}

//TODO: confirmação de que algo foi salvo com um toast
