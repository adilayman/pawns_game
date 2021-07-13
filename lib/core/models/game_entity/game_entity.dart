import 'package:flutter/material.dart';
import 'package:info2051_2018/core/utils/vector.dart';

/// GameEntity presentation
abstract class GameEntity {
  Vector _coordinate;
  Vector velocity = Vector(0, 0);

  double speed = 15;

  bool moving = false;

  int frames = 0;

  GameEntity(this._coordinate);

  /// render the game entity in the given canvas
  void render(Canvas canvas);

  /// update the game entity at each frame
  bool update(double dt);

  /// check if the given position is inside the game entity
  bool contains(Offset position);

  /// perform a procedure on long press gesture
  void onLongPressMoveUpdate(Offset position);

  /// perform a procedure on long press start gesture
  void onLongPressStart(Offset position);

  /// perform a procedure on long press end gesture
  void onLongPressEnd(Offset position);

  /* setters section */
  set x(double value) => _coordinate.x = value;
  set y(double value) => _coordinate.y = value;

  /* getters section */
  Vector get coordinate => _coordinate;
  double get x => _coordinate.x;
  double get y => _coordinate.y;
}
