import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pawns_game/entities/arrow.dart';

import 'package:gamez/gamez.dart';

class FootballPawn extends CircularEntity {
  final Arrow _arrow = Arrow();

  bool _startPress = false;
  bool _canMove = false;

  FootballPawn(Vector position, ImageRenderer? image)
      : super(position, 23, image: image);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // renders the arrow only if the pawn can move and it's pressed.
    if (_startPress && canMove) _arrow.render(canvas);
  }

  @override
  void update(double dt) {
    var friction = 0.05;
    velocity += -velocity * friction;

    position += velocity * dt;
    _arrow.position = position;
  }

  void _onLongPressStart(Offset position) {
    if (!contains(position)) return;
    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
    _startPress = true;
  }

  void _onLongPressMoveUpdate(Offset position) {
    if (!_startPress) return;
    _arrow.angle = pi - atan2(position.dy - y, position.dx - x);
  }

  void _onLongPressEnd(Offset position) {
    if (!_startPress) return;

    double angle = pi - atan2(position.dy - y, position.dx - x);

    var speed = 1000;
    velocity.x = speed * cos(angle);
    velocity.y = -speed * sin(angle);

    _startPress = false;
  }

  @override
  void reset() {
    _arrow.position = position;
    velocity = Vector(0, 0);
  }

  bool get startPress => _startPress;

  set canMove(bool value) {
    _startPress = false;
    _canMove = value;
  }

  bool get canMove => _canMove;

  @override
  void handleGesture(Offset position, Gesture gesture) {
    switch (gesture) {
      case Gesture.longPressStart:
        _onLongPressStart(position);
        break;
      case Gesture.longPressMoveUpdate:
        _onLongPressMoveUpdate(position);
        break;
      case Gesture.longPressEnd:
        _onLongPressEnd(position);
        break;
      default:
    }
  }
}
