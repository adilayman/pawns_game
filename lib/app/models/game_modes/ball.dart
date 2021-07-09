import 'package:flutter/material.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/core/models/game_entity/circle_entity.dart';
import 'package:info2051_2018/core/utils/vector.dart';

import 'dart:ui' as ui;

class Ball extends CircleEntity {
  ui.Image _image;

  Ball(Vector point, Game game) : super(point, 30, Colors.red.shade900, game);

  @override
  void render(Canvas canvas) {
    if (_image != null)
      canvas.drawImageRect(
        _image,
        Rect.fromLTWH(0, 0, _image.width.toDouble(), _image.height.toDouble()),
        Rect.fromLTWH(coordinate.x - radius, coordinate.y - radius, 2 * radius,
            2 * radius),
        Paint(),
      );
    else
      super.render(canvas);
  }

  @override
  void onLongPressEnd(Offset position) {}

  @override
  void onLongPressMoveUpdate(Offset position) {}

  @override
  void onLongPressStart(Offset position) {}

  @override
  bool update(double dt) {
    return false;
  }
}
