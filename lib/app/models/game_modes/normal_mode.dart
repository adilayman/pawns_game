import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/pawn.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class NormalMode extends Game {
  NormalMode() {
    addEntity(Pawn(Vector(430, 100), Colors.red.shade900, this));
    addEntity(Pawn(Vector(500, 100), Colors.blue.shade900, this));
    addEntity(Pawn(Vector(580, 100), Colors.blue.shade900, this));
  }

  @override
  void render(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green.shade800
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Offset(size.width * 0.1, size.height * 0.2) &
            Size(
                size.width - size.width * 0.2, size.height - size.height * 0.2),
        paint);

    Size scoreBarSize = Size(size.width, size.height * 0.2);

    paint
      ..color = Colors.grey.shade100
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & scoreBarSize, paint);

    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.red.shade400,
        Colors.grey,
        Colors.blue.shade400,
      ],
    ).createShader(Offset.zero & scoreBarSize);

    canvas.drawRect(Offset.zero & scoreBarSize, paint);

    //
    paint.shader = null;
    paint.color = Colors.grey.shade700;

    var borders = Rect.fromLTWH(
        0, scoreBarSize.height, size.width, size.height - scoreBarSize.height);

    final rrectBorders = RRect.fromRectAndRadius(borders, Radius.circular(0));

    paint
      ..color = Colors.grey.shade900
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrectBorders, paint);

    super.render(canvas, size);

    paint..color = Colors.black;
    canvas.drawPoints(
        PointMode.points, [Offset(collisionP.x, collisionP.y)], paint);
  }
}
