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
  bool moving = false;

  int frames = 0;

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
    if (!moving) return false;

    coordinate.x += dt * velocity.x * 12;
    coordinate.y += dt * velocity.y * 12;

    game.entities.forEach((entity) {
      if (!identical(this, entity) && entity is Pawn) {
        if (circleCollision(this, entity)) {
          game.collisionP.x = ((x * entity.radius) + (entity.x * radius)) /
              (radius + entity.radius);

          game.collisionP.y = ((y * entity.radius) + (entity.y * radius)) /
              (radius + entity.radius);

          // Vector tangentVector = Vector(entity.y - y, -(entity.x - x));

          // tangentVector = tangentVector.normalize();

          // Vector relativeVelocity = Vector(
          //     velocity.x - entity.velocity.x, velocity.y - entity.velocity.y);

          // double length = relativeVelocity.x * tangentVector.x +
          //     relativeVelocity.y * tangentVector.y;

          // Vector velocityComponentOnTangent =
          //     Vector(tangentVector.x * length, tangentVector.y * length);

          // velocity.x -= (relativeVelocity.x - velocityComponentOnTangent.x);
          // velocity.y -= (relativeVelocity.y - velocityComponentOnTangent.y);

          // entity.velocity.x +=
          //     (relativeVelocity.x - velocityComponentOnTangent.x);
          // entity.velocity.y +=
          //     (relativeVelocity.y - velocityComponentOnTangent.y);

          // entity.frames = 5;
          // entity.moving = true;

          ////////////////////////////////

          double dx = x - entity.x;
          double dy = y - entity.y;

          double nl = sqrt(dx * dx + dy * dy);

          var nx = -dx / nl;
          var ny = -dy / nl;
          // calculate new velocity: v' = v - 2 * dot(d, v) * n
          double dot = velocity.x * nx + velocity.y * ny;
          velocity.x -= 2 * dot * nx;
          velocity.y -= 2 * dot * ny;

          entity.velocity.x += 2 * dot * nx;
          entity.velocity.y += 2 * dot * ny;

          entity.frames = 5;
          entity.moving = true;

          /////////////////////////////////////

          // velocity.x = (velocity.x * (radius - entity.radius) +
          //         (2 * entity.radius * entity.velocity.x)) /
          //     (radius + entity.radius);
          // velocity.y = (velocity.y * (radius - entity.radius) +
          //         (2 * entity.radius * entity.velocity.y)) /
          //     (radius + entity.radius);

          ////////////////////////

          // Vector vCollision = Vector(entity.x - x, entity.y - y);

          // double distance = sqrt((entity.x - x) * (entity.x - x) +
          //     (entity.y - y) * (entity.y - y));

          // Vector vCollisionNorm =
          //     Vector(vCollision.x / distance, vCollision.y / distance);

          // Vector vRelativeVelocity = Vector(
          //     velocity.x - entity.velocity.x, velocity.y - entity.velocity.y);

          // // aa
          // double s = vRelativeVelocity.x * vCollisionNorm.x +
          //     vRelativeVelocity.y * vCollisionNorm.y;

          // velocity.x -= (s * vCollisionNorm.x);
          // velocity.y -= (s * vCollisionNorm.y);

          // coordinate.x += dt * velocity.x;
          // coordinate.y += dt * velocity.y;

          ///////////////////////
          ///
          ///

          // double sp = 12;

          // double newVelX1 =
          //     (sp * (radius - entity.radius) + (2 * entity.radius * sp)) /
          //         (radius + entity.radius);
          // double newVelY1 =
          //     (sp * (radius - entity.radius) + (2 * entity.radius * sp)) /
          //         (radius + entity.radius);

          // velocity.x = x + newVelX1;
          // velocity.y = -(y + newVelY1);

          frames = 5;
        }
      }
    });

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

    velocity.x = speed * cos(angle);
    velocity.y = -speed * sin(angle);

    print(velocity.y);

    moving = true;
    frames = 30;

    _startPress = false;
  }
}
