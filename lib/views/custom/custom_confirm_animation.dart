import 'package:flutter/material.dart';
import 'dart:math';

// https://stackoverflow.com/a/54556077 com algumas edições

//TODO: V saindo fora do botão

class CustomConfirmAnimation extends StatefulWidget {
  final double size;
  final Duration duration;
  final Curve curve;
  final Color color;
  final VoidCallback onComplete;

  CustomConfirmAnimation({
    required this.color,
    required this.onComplete,
    this.size = 100,
    this.curve = Curves.easeInQuart,
    this.duration = const Duration(seconds: 2),
  });

  @override
  _CustomConfirmAnimationState createState() => _CustomConfirmAnimationState();
}

class _CustomConfirmAnimationState extends State<CustomConfirmAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..addListener(() => setState(() {
            if (_controller.status == AnimationStatus.completed) {
              widget.onComplete();
            }
          }))
      ..forward();
    _curveAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      color: Colors.transparent,
      child: CustomPaint(
        painter: ConfirmPainter(
          value: _curveAnimation.value,
          color: widget.color,
        ),
      ),
    );
  }
}

class ConfirmPainter extends CustomPainter {
  Color color;

  double value;
  double _length = 60;
  double _offset = 0;
  double _startingAngle = 205;

  ConfirmPainter({required this.value, required this.color});

  double radian(double degree) {
    return degree / 180.0 * pi;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = 6.0
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect = Offset(0, 0) & size;

    double line1x1 =
        size.width / 2 + size.width * cos(radian(_startingAngle)) * .5;
    double line1y1 =
        size.height / 2 + size.height * sin(radian(_startingAngle)) * .5;
    double line1x2 = size.width * .45;
    double line1y2 = size.height * .65;

    double line2x1 = size.width / 2 + size.width * cos(radian(320)) * .35;
    double line2y1 = size.height / 2 + size.height * sin(radian(320)) * .35;

    canvas.drawArc(
      rect,
      radian(_startingAngle),
      radian(360),
      false,
      _paint,
    );

    canvas.drawLine(Offset(line1x1, line1y1), Offset(line1x2, line1y2), _paint);
    canvas.drawLine(Offset(line2x1, line2y1), Offset(line1x2, line1y2), _paint);

    double circleValue, checkValue;
    if (value < .5) {
      checkValue = 0;
      circleValue = value / .5;
    } else {
      checkValue = (value - .5) / .5;
      circleValue = 1;
    }

    _paint.color = color;
    double firstAngle = _startingAngle + 360 * circleValue;

    canvas.drawArc(
        rect,
        radian(firstAngle),
        radian(getSecondAngle(
          firstAngle,
          _length,
          _startingAngle + 360,
        )),
        false,
        _paint);

    double line1Value = 0, line2Value = 0;
    if (circleValue >= 1) {
      if (checkValue < .5) {
        line2Value = 0;
        line1Value = checkValue / .5;
      } else {
        line2Value = (checkValue - .5) / .5;
        line1Value = 1;
      }
    }

    double auxLine1x1 = (line1x2 - line1x1) * getMin(line1Value, .8);
    double auxLine1y1 =
        (((auxLine1x1) - line1x1) / (line1x2 - line1x1)) * (line1y2 - line1y1) +
            line1y1;

    if (_offset < 60) {
      auxLine1x1 = line1x1;
      auxLine1y1 = line1y1;
    }

    double auxLine1x2 = auxLine1x1 + _offset / 2;
    double auxLine1y2 =
        (((auxLine1x1 + _offset / 2) - line1x1) / (line1x2 - line1x1)) *
                (line1y2 - line1y1) +
            line1y1;

    if (checkIfPointHasCrossedLine(Offset(line1x2, line1y2),
        Offset(line2x1, line2y1), Offset(auxLine1x2, auxLine1y2))) {
      auxLine1x2 = line1x2;
      auxLine1y2 = line1y2;
    }

    if (_offset > 0) {
      canvas.drawLine(Offset(auxLine1x1, auxLine1y1),
          Offset(auxLine1x2, auxLine1y2), _paint);
    }

    double auxLine2x1 = (line2x1 - line1x2) * line2Value;
    double auxLine2y1 =
        ((((line2x1 - line1x2) * line2Value) - line1x2) / (line2x1 - line1x2)) *
                (line2y1 - line1y2) +
            line1y2;

    if (checkIfPointHasCrossedLine(Offset(line1x1, line1y1),
        Offset(line1x2, line1y2), Offset(auxLine2x1, auxLine2y1))) {
      auxLine2x1 = line1x2;
      auxLine2y1 = line1y2;
    }
    if (line2Value > 0) {
      canvas.drawLine(
          Offset(auxLine2x1, auxLine2y1),
          Offset(
              (line2x1 - line1x2) * line2Value + _offset * .75,
              ((((line2x1 - line1x2) * line2Value + _offset * .75) - line1x2) /
                          (line2x1 - line1x2)) *
                      (line2y1 - line1y2) +
                  line1y2),
          _paint);
    }
  }

  double getMax(double x, double y) {
    return (x > y) ? x : y;
  }

  double getMin(double x, double y) {
    return (x > y) ? y : x;
  }

  bool checkIfPointHasCrossedLine(Offset a, Offset b, Offset point) {
    return ((b.dx - a.dx) * (point.dy - a.dy) -
            (b.dy - a.dy) * (point.dx - a.dx)) >
        0;
  }

  double getSecondAngle(double angle, double plus, double max) {
    if (angle + plus > max) {
      _offset = angle + plus - max;
      return max - angle;
    } else {
      _offset = 0;
      return plus;
    }
  }

  @override
  bool shouldRepaint(ConfirmPainter old) {
    return true;
  }
}
