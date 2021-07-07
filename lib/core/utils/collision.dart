import 'dart:math';

import 'package:info2051_2018/core/models/game_entity/circle_entity.dart';

// check if c1 and c2 collide
bool circleCollision(CircleEntity c1, CircleEntity c2) {
  double dx = c1.x - c2.x;
  double dy = c1.y - c2.y;
  return sqrt(dx * dx + dy * dy) < c1.radius + c2.radius;
}


          // double dx = x - entity.x;
          // double dy = y - entity.y;

          // double nl = sqrt(dx * dx + dy * dy);

          // var nx = -dx / nl;
          // var ny = -dy / nl;
          // // calculate new velocity: v' = v - 2 * dot(d, v) * n
          // double dot = velocity.x * nx + velocity.y * ny;
          // velocity.x = velocity.x - 2 * dot * nx;
          // velocity.y = velocity.y - 2 * dot * ny;
