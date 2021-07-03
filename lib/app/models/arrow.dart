import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:info2051_2018/core/models/game_entity/game_entity.dart';
import 'package:info2051_2018/core/utils/vector.dart';

/// Circle Entity presentation
class Arrow extends GameEntity {
  Color _color;
  late Vector endPoint;
  double angle = 0;

  Arrow(Vector point, this._color, game) : super(point, game) {
    endPoint = Vector(point.x, point.y);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint();
    paint.color = _color;
    paint.strokeWidth = 3;

    endPoint.x = x + 100 * cos(angle);
    endPoint.y = y - 100 * sin(angle);

    canvas.drawLine(Offset(x, y), Offset(endPoint.x, endPoint.y), paint);

    canvas.drawLine(
        Offset(endPoint.x, endPoint.y),
        Offset(
          endPoint.x - 10 * cos(angle + 0.4),
          endPoint.y + 10 * sin(angle + 0.4),
        ),
        paint);

    canvas.drawLine(
        Offset(endPoint.x, endPoint.y),
        Offset(
          endPoint.x - 10 * cos(angle + 0.4),
          endPoint.y + 10 * sin(angle - 0.4),
        ),
        paint);
  }

  @override
  bool contains(Offset position) => false;

  @override
  void onLongPressStart(Offset position) {}

  @override
  void onLongPressEnd(Offset position) {}

  @override
  bool update(double dt) => false;

  @override
  void onLongPressMoveUpdate(Offset position) {}
}
