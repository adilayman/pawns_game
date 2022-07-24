import 'dart:ui';

import 'package:gamez/gamez.dart';

class Football extends CircularEntity {
  Football(Vector position, ImageRenderer? image)
      : super(position, 15, image: image);

  @override
  void update(double dt) {
    var friction = 0.03;
    velocity += -velocity * friction;

    position += velocity * dt;
  }

  @override
  void reset() => velocity = Vector(0, 0);

  @override
  void handleGesture(Offset position, Gesture gesture) {}
}
