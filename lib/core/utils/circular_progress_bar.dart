import 'dart:math';

import 'package:flutter/material.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class CircularProgressBar {
  Vector _center;
  double _radius;

  double _maxValue;

  double currentValue = 0;

  Color initialColor = Colors.green;
  Color progressColor = Colors.red;

  CircularProgressBar(this._center, this._radius, this._maxValue);

  void _renderBaseCircle(Canvas canvas) {
    Paint paint = Paint()
      ..color = initialColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(_center.toOffset, _radius, paint);
  }

  void _renderProgressCircle(Canvas canvas) {
    Paint paint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Rect rect = Rect.fromLTWH(
        _center.x - _radius, _center.y - _radius, 2 * _radius, 2 * _radius);

    double startAngle = -pi / 2;
    double currentAngle = 2 * currentValue * pi / _maxValue;

    canvas.drawArc(rect, startAngle, currentAngle, false, paint);
  }

  void render(Canvas canvas) {
    _renderBaseCircle(canvas);
    _renderProgressCircle(canvas);
  }
}
