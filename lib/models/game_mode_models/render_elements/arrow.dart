import 'dart:math';

import 'package:flutter/material.dart';

import 'package:gamez/gamez.dart';

class Arrow extends RenderElement {
  double angle = 0;

  double _barAngle = 0.78;

  Arrow() : super(Vector(0, 0), Size(3, 70));

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Color.fromRGBO(255, 255, 255, 0.8)
      ..strokeWidth = size.width;

    var _endPoint = Vector(0, 0);
    _endPoint.x = x + size.height * cos(angle);
    _endPoint.y = y - size.height * sin(angle);

    canvas.drawLine(Offset(x, y), Offset(_endPoint.x, _endPoint.y), paint);

    canvas.drawLine(
      Offset(_endPoint.x, _endPoint.y),
      Offset(
        _endPoint.x +
            (10 / size.height) *
                ((x - _endPoint.x) * cos(_barAngle) -
                    (y - _endPoint.y) * sin(_barAngle)),
        _endPoint.y +
            (10 / size.height) *
                ((y - _endPoint.y) * cos(_barAngle) +
                    (x - _endPoint.x) * sin(_barAngle)),
      ),
      paint,
    );

    canvas.drawLine(
      Offset(_endPoint.x, _endPoint.y),
      Offset(
        _endPoint.x +
            (10 / size.height) *
                ((x - _endPoint.x) * cos(_barAngle) +
                    (y - _endPoint.y) * sin(_barAngle)),
        _endPoint.y +
            (10 / size.height) *
                ((y - _endPoint.y) * cos(_barAngle) -
                    (x - _endPoint.x) * sin(_barAngle)),
      ),
      paint,
    );
  }

  @override
  bool contains(Offset position) => false;
}
