import 'package:flutter/material.dart';

/// Desenha a barra de menu. Recebe como parâmetro a cor de fundo.
class NavbarCustomPainter extends CustomPainter {
  final Color mainColor;

  NavbarCustomPainter(this.mainColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 15);

    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(Offset(size.width * 0.6, 20),
        radius: Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 15);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
