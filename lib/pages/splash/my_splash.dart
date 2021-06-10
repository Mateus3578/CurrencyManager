import 'package:flutter/material.dart';
import 'package:tc/pages/home/home.dart';

class MySplash extends StatefulWidget {
  @override
  MySplashState createState() => MySplashState();
}

class MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    delay();
  }

  // Delay entre a tela de início e o app
  Future<void> delay() async {
    return await Future.delayed(
      Duration(milliseconds: 1400),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return Home();
          }),
        );
      },
    );
  }

  // Tela de início ao abrir o app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Icon(
          Icons.attach_money,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
