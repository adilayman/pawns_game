import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pawns_game/app/models/game_mode_models/render_elements/arrow.dart';
import 'package:pawns_game/core/models/game_entities/circular_sprite.dart';

import 'package:pawns_game/core/resources/sprite.dart';
import 'package:pawns_game/core/resources/vector.dart';

class FootballPawn extends CircularSprite {
  Arrow _arrow;

  bool _startPress = false;
  bool _canMove = false;

  FootballPawn(Vector position, Sprite sprite) : super(position, 23) {
    _arrow = Arrow(position);
    super.sprite = sprite;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // renders the arrow only if the pawn can move and it's pressed.
    if (_startPress && canMove) _arrow.render(canvas);
  }

  @override
  void update(double dt) {
    if (_startPress) return;

    if (currentSpeed <= 0) velocity = Vector(0, 0);

    position.x += dt * velocity.x;
    position.y += dt * velocity.y;

    currentSpeed -= dt * speed;
  }

  @override
  void onLongPressStart(Offset position) {
    if (!contains(position)) return;
    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
    _startPress = true;
  }

  void onLongPressMoveUpdate(Offset position) {
    if (!_startPress) return;
    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
  }

  @override
  void onLongPressEnd(Offset position) {
    if (!_startPress) return;

    double angle = pi - atan2(position.dy - y, position.dx - x);

    speed = 230;

    velocity.x = speed * cos(angle);
    velocity.y = -speed * sin(angle);

    _startPress = false;
  }

  @override
  void reset() {
    _arrow.position = position;
    velocity = Vector(0, 0);
    currentSpeed = 0;
  }

  bool get startPress => _startPress;

  set canMove(bool value) {
    _startPress = false;
    _canMove = value;
  }

  bool get canMove => _canMove;
}
