import 'package:flutter/material.dart';

/// PageRoute customizado
class BouncyPageRouter extends PageRouteBuilder {
  ///Para onde deve ir depois da animação
  final Widget widget;

  ///Duração da animação
  final Duration duration;

  ///Efeito da animação
  final Curve curve;

  BouncyPageRouter({
    required this.widget,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOut,
  }) : super(
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => widget,
        );
}
