import 'dart:ui';

import 'package:pawns_game/app/models/game_mode_models/game_entities/circular_sprite.dart';

import 'package:pawns_game/core/resources/sprite.dart';
import 'package:pawns_game/core/resources/vector.dart';

class Football extends CircularSprite {
  Football(Vector position, Sprite sprite) : super(position, 15) {
    super.sprite = sprite;
  }

  @override
  void update(double dt) {
    if (currentSpeed <= 0) velocity = Vector(0, 0);

    position.x += dt * velocity.x;
    position.y += dt * velocity.y;

    currentSpeed -= dt * speed;
  }

  @override
  void onLongPressEnd(Offset position) {}

  @override
  void onLongPressMoveUpdate(Offset position) {}

  @override
  void onLongPressStart(Offset position) {}

  @override
  void reset() => velocity = Vector(0, 0);
}
