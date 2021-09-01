import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pawns_game/core/models/game_entities/circular_sprite.dart';

import 'package:pawns_game/core/resources/sprite.dart';
import 'package:pawns_game/core/resources/vector.dart';

class CircularProgressBar extends CircularSprite {
  double _max;
  double current = 0;

  Color initialColor = Colors.green;
  Color progressColor = Colors.red;

  CircularProgressBar(Vector position, double radius, this._max,
      {Sprite sprite})
      : super(position, radius) {
    super.sprite = sprite;
  }

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
    double currentAngle = 2 * current * pi / _max;

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
  void onLongPressEnd(Offset position) {}

  @override
  void onLongPressMoveUpdate(Offset position) {}

  @override
  void onLongPressStart(Offset position) {}
}
