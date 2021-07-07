import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_mode.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/app/models/arrow.dart';
import 'package:info2051_2018/core/models/game_entity/circle_entity.dart';
import 'package:info2051_2018/core/utils/collision.dart';
import 'package:info2051_2018/core/utils/image_loader.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class Pawn extends CircleEntity {
  bool _startPress = false;
  bool moving = false;

  int frames = 0;

  Arrow _arrow;

  bool _waitingForLoad = true;

  Pawn(Vector point, Color color, Game game) : super(point, 30, color, game) {
    _arrow = Arrow(point, Colors.black, game);
    imageLoader = ImageLoader("lib/app/images/pawns/blue_pawn.png")
      ..loadImage();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (imageLoader.image != null)
      canvas.drawImageRect(
        imageLoader.image,
        Rect.fromLTWH(0, 0, imageLoader.image.width.toDouble(),
            imageLoader.image.height.toDouble()),
        Rect.fromLTWH(coordinate.x - radius, coordinate.y - radius, 2 * radius,
            2 * radius),
        Paint(),
      );

    if (_startPress) _arrow.render(canvas);
  }

  @override
  bool update(double dt) {
    if (_startPress) return true;
    if (!moving) {
      if (_waitingForLoad && imageLoader.isLoaded) {
        _waitingForLoad = false;
        return true;
      }
      return false;
    }

    coordinate.x += dt * velocity.x;
    coordinate.y += dt * velocity.y;

    if (coordinate.y <= 65) moving = false;

    game.entities.forEach((entity) {
      if (!identical(this, entity) && entity is Pawn) {
        if (circleCollision(this, entity)) {
          game.collisionP.x = ((x * entity.radius) + (entity.x * radius)) /
              (radius + entity.radius);

          game.collisionP.y = ((y * entity.radius) + (entity.y * radius)) /
              (radius + entity.radius);

          double dx = x - entity.x;
          double dy = y - entity.y;

          double nl = sqrt(dx * dx + dy * dy);

          var nx = -dx / nl;
          var ny = -dy / nl;
          // calcunew velocity: v' = v - 2 * dot(d, v) * n
          double dot = velocity.x * nx + velocity.y * ny;
          velocity.x -= 2 * dot * nx;
          velocity.y -= 2 * dot * ny;

          entity.velocity.x += dot * nx;
          entity.velocity.y += dot * ny;

          entity.frames = 5;
          entity.moving = true;

          frames = 5;
        }
      }
    });

    SoccerMode g = game as SoccerMode;

    if (x - radius <= g.field.topLeft.x) {
      x = g.field.topLeft.x + radius;
      velocity.x *= -1;
    }

    if (x + radius >= g.field.topRight.x) {
      x = g.field.topRight.x - radius;
      velocity.x *= -1;
    }

    if (y - radius <= g.field.topLeft.y) {
      y = g.field.topLeft.y + radius;
      velocity.y *= -1;
    }

    if (y + radius >= g.field.bottomRight.y) {
      y = g.field.bottomRight.y - radius;
      velocity.y *= -1;
    }

    //print(coordinate.x);

    if (frames-- == 0) moving = false;

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
