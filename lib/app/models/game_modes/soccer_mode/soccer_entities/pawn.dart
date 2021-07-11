import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_mode.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/app/models/arrow.dart';
import 'package:info2051_2018/core/models/game_entity/circle_entity.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class Pawn extends CircleEntity {
  bool _startPress = false;
  bool moving = false;

  int frames = 0;

  bool collide = false;

  Arrow _arrow;

  ui.Image _image;

  Function collisionSys;

  Pawn(Vector point, Game game, {this.collisionSys})
      : super(point, 30, Colors.red.shade900, game) {
    _arrow = Arrow(point, Colors.white54, game);
  }

  void loadImage(ui.Image image) => _image = image;

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

    if (_startPress) _arrow.render(canvas);
  }

  @override
  bool update(double dt) {
    if (_startPress) return true;
    if (!moving) return false;

    coordinate.x += dt * velocity.x;
    coordinate.y += dt * velocity.y;

    if (collisionSys != null) collisionSys(this);

    if (frames-- == 0) moving = false;

    collide = false;

    return true;
  }

  @override
  void onLongPressStart(Offset position) {
    if (!contains(position)) return;
    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
    _arrow.calculateEndPoint(position);
    _startPress = true;
  }

  void onLongPressMoveUpdate(Offset position) {
    if (!_startPress) return;
    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
    _arrow.calculateEndPoint(position);
  }

  @override
  void onLongPressEnd(Offset position) {
    if (!_startPress) return;

    double angle = pi - atan2(position.dy - y, position.dx - x);

    speed = 200;

    velocity.x = speed * cos(angle);
    velocity.y = -speed * sin(angle);

    moving = true;
    frames = 30;

    _startPress = false;
  }
}
