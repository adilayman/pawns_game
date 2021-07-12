import 'dart:math';

import 'package:info2051_2018/core/models/game_entity/circle_entity.dart';

// check if c1 and c2 collide
bool circleCollision(CircleEntity c1, CircleEntity c2) {
  double dx = c1.x - c2.x;
  double dy = c1.y - c2.y;
  return dx * dx + dy * dy <= (c1.radius + c2.radius) * (c1.radius + c2.radius);
}

void resolveCircle(CircleEntity c1, CircleEntity c2) {
  double dx = c1.x - c2.x;
  double dy = c1.y - c2.y;

  double length = sqrt(dx * dx + dy * dy);
  double ux = dx / length;
  double uy = dy / length;

  c1.x = c2.x + (c1.radius + c2.radius + 1) * ux;
  c1.y = c2.y + (c1.radius + c2.radius + 1) * uy;
}
