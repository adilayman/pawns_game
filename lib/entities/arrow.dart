import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gamez/gamez.dart';

class Arrow extends GameEntity {
  double angle = 0;

  final double _barAngle = 0.78;

  Arrow() : super(Vector(0, 0), const Size(3, 70));

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = const Color.fromRGBO(255, 255, 255, 0.8)
      ..strokeWidth = size.width;

    var endPoint = Vector(0, 0);
    endPoint.x = x + size.height * cos(angle);
    endPoint.y = y - size.height * sin(angle);

    canvas.drawLine(Offset(x, y), Offset(endPoint.x, endPoint.y), paint);

    canvas.drawLine(
      Offset(endPoint.x, endPoint.y),
      Offset(
        endPoint.x +
            (10 / size.height) *
                ((x - endPoint.x) * cos(_barAngle) -
                    (y - endPoint.y) * sin(_barAngle)),
        endPoint.y +
            (10 / size.height) *
                ((y - endPoint.y) * cos(_barAngle) +
                    (x - endPoint.x) * sin(_barAngle)),
      ),
      paint,
    );

    canvas.drawLine(
      Offset(endPoint.x, endPoint.y),
      Offset(
        endPoint.x +
            (10 / size.height) *
                ((x - endPoint.x) * cos(_barAngle) +
                    (y - endPoint.y) * sin(_barAngle)),
        endPoint.y +
            (10 / size.height) *
                ((y - endPoint.y) * cos(_barAngle) -
                    (x - endPoint.x) * sin(_barAngle)),
      ),
      paint,
    );
  }

  @override
  bool contains(Offset position) => false;

  @override
  void reset() {}

  @override
  void update(double dt) {}

  @override
  void handleGesture(Offset position, Gesture gesture) {}
}
