import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/pawn.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class NormalMode extends Game {
  NormalMode() {
    addEntity(Pawn(Vector(500, 100), Colors.red.shade900, this));
    addEntity(Pawn(Vector(400, 200), Colors.blue.shade900, this));
  }

  @override
  void render(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade700
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, paint);

    var borders = Rect.fromLTWH(0, 0, size.width, size.height);

    final rrectBorders = RRect.fromRectAndRadius(borders, Radius.circular(0));

    paint
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrectBorders, paint);

    super.render(canvas, size);

    paint..color = Colors.black;
    canvas.drawPoints(
        PointMode.points, [Offset(collisionP.x, collisionP.y)], paint);
  }
}
