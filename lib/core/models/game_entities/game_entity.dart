import 'package:flutter/material.dart';

import 'package:pawns_game/core/models/game/game_gesture.dart';
import 'package:pawns_game/core/models/render_elements/render_element.dart';
import 'package:pawns_game/core/resources/vector.dart';

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
