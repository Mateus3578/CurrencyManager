import 'package:flutter/material.dart';

/// Icone animado customizado
///
/// Se mexe de um lado para outro ou cima para baixo
class CustomAnimatedShake extends StatefulWidget {
  /// Direções para passar como parâmetro ao construir a animação
  static const verticalDirection = true;
  static const horizontalDirection = false;

  /// Duração da animação.
  ///
  /// Padrão: 2 segundos
  final Duration duration;

  /// Distancia que o widget percorre entre o início e o fim da animação.
  ///
  /// Padrão: 10%
  final double delta;

  /// Widget que vai ser animado
  final Widget child;

  /// Efeito da animação.
  ///
  /// Padrão: Curves.bounceOut
  final Curve curve;

  /// Direção da animação. A classe possui constantes para facilitar a troca.
  ///
  /// Uso:
  ///
  /// ```dart
  /// CustomAnimatedShake.verticalDirection ou true
  /// CustomAnimatedShake.horizontalDirection ou false
  /// ```
  final bool direction;

  const CustomAnimatedShake({
    this.duration = const Duration(seconds: 2),
    this.delta = 10,
    this.curve = Curves.bounceOut,
    this.direction = verticalDirection,
    required this.child,
  });

  @override
  _CustomAnimatedShakeState createState() => _CustomAnimatedShakeState();
}

class _CustomAnimatedShakeState extends State<CustomAnimatedShake>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (_controller.isCompleted) {
          _controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// convert 0-1 to 0-1-0
  double shake(double value) =>
      2 * (0.5 - (0.5 - widget.curve.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: widget.direction
            ? Offset(0, widget.delta * shake(_controller.value))
            : Offset(widget.delta * shake(_controller.value), 0),
        child: child,
      ),
      child: widget.child,
    );
  }
}
