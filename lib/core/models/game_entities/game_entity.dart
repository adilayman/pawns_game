import 'package:flutter/material.dart';

import '../../resources/vector.dart';
import '../game/game_gesture.dart';
import '../render_elements/render_element.dart';

/// Abstract representation of a game entity.
abstract class GameEntity extends RenderElement implements GameGesture {
  Vector velocity = Vector(0, 0);
  double _speed = 0;
  double currentSpeed = 0;

  GameEntity(Vector position, Size size) : super(position, size);

  double get speed => _speed;

  set speed(double newSpeed) {
    _speed = newSpeed;
    currentSpeed = newSpeed;
  }
}
