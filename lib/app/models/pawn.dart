import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/app/models/arrow.dart';
import 'package:info2051_2018/core/models/game_entity/circle_entity.dart';
import 'package:info2051_2018/core/utils/collision.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class Pawn extends CircleEntity {
  bool _startPress = false;
  bool _moving = false;

  int _frames = 0;

  late Arrow _arrow;

  Pawn(Vector point, Color color, Game game) : super(point, 30, color, game) {
    _arrow = Arrow(point, Colors.black, game);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_startPress) _arrow.render(canvas);
  }

  @override
  bool update(double dt) {
    if (_startPress) return true;
    if (!_moving) return false;

    game.entities.forEach((entity) {
      if (!identical(this, entity) && entity is Pawn) {
        if (circleCollision(this, entity)) {
          game.collisionP.x = ((x * entity.radius) + (entity.x * radius)) /
              (radius + entity.radius);

          game.collisionP.y = ((y * entity.radius) + (entity.y * radius)) /
              (radius + entity.radius);

          velocity.x = (speed * (radius - entity.radius) +
                  (2 * entity.radius * entity.speed)) /
              (radius + entity.radius);
          velocity.y = -((speed * (radius - entity.radius) +
                  (2 * entity.radius * entity.speed)) /
              (radius + entity.radius));

          _frames = 5;
        }
      }
    });

    coordinate.x += velocity.x;
    coordinate.y -= velocity.y;

    //print(coordinate.x);

    if (_frames-- == 0) _moving = false;

    return true;
  }

  @override
  void onLongPressStart(Offset position) {
    if (!contains(position)) return;
    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
    _startPress = true;
  }

  void onLongPressMoveUpdate(Offset position) {
    if (!_startPress) return;

    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
  }

  @override
  void onLongPressEnd(Offset position) {
    if (!_startPress) return;

    double angle = pi - atan2(position.dy - y, position.dx - x);

    velocity.x = speed * cos(angle);
    velocity.y = speed * sin(angle);

    print(velocity.y);

    _moving = true;
    _frames = 30;

    _startPress = false;
  }
}
