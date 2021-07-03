import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:info2051_2018/core/models/game_entity/game_entity.dart';
import 'package:info2051_2018/core/utils/vector.dart';

/// Circle Entity presentation
abstract class CircleEntity extends GameEntity {
  double radius;
  Color _color;

  CircleEntity(Vector point, this.radius, this._color, game)
      : super(point, game);

  @override
  void render(Canvas canvas) {
    final paint = Paint();
    paint.color = _color;
    var center = Offset(coordinate.x, coordinate.y);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool contains(Offset position) {
    final Offset center = Offset(coordinate.x, coordinate.y);
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: center,
            width: 2 * radius,
            height: 2 * radius,
          ),
          Radius.circular(center.dx),
        ),
      )
      ..close();

    return path.contains(position);
  }

  @override
  void onLongPressMoveUpdate(Offset position);

  @override
  void onLongPressStart(Offset position);

  @override
  void onLongPressEnd(Offset position);

  @override
  bool update(double dt);
}
