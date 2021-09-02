import 'dart:ui';

import 'package:flutter/material.dart';

import '../../resources/sprite.dart';
import '../../resources/vector.dart';

/// Abstract representation of a render element.
abstract class RenderElement {
  Vector position;
  Size size;
  Sprite sprite;

  RenderElement(this.position, this.size);

  /// Renders the game entity.
  void render(Canvas canvas);

  /// Updates the game entity at each frame.
  void update(double dt) {}

  /// Resets the state.
  void reset() {}

  /// Checks if [position] is in the render element.
  bool contains(Offset position);

  set x(double value) => position.x = value;

  set y(double value) => position.y = value;

  double get x => position.x;

  double get y => position.y;
}
