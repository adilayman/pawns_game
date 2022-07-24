import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gamez/gamez.dart';

class CircularProgressBar extends CircularEntity {
  double max;
  double current = 0;

  Color initialColor = Colors.green;
  Color progressColor = Colors.red;

  CircularProgressBar(Vector position, double radius, this.max,
      {ImageRenderer? image})
      : super(position, radius, image: image);

  /// Renders the base circle.
  void _renderBaseCircle(Canvas canvas) {
    Paint paint = Paint()
      ..color = initialColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(position.toOffset, radius, paint);
  }

  /// Renders the progress circle.
  void _renderProgressCircle(Canvas canvas) {
    Paint paint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    Rect rect = Rect.fromLTWH(x - radius, y - radius, 2 * radius, 2 * radius);

    double startAngle = -pi / 2;
    double currentAngle = 2 * current * pi / max;

    canvas.drawArc(rect, startAngle, currentAngle, false, paint);
  }

  @override
  void render(Canvas canvas) {
    _renderBaseCircle(canvas);
    _renderProgressCircle(canvas);
    super.render(canvas);
  }

  @override
  void reset() => current = 0;

  @override
  void update(double dt) {}

  @override
  void handleGesture(Offset position, Gesture gesture) {}
}
