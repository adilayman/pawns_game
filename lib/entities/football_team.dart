import 'package:flutter/material.dart';
import 'package:gamez/gamez.dart';

import 'package:pawns_game/models/player.dart';
import 'package:pawns_game/entities/football_pawn.dart';

class FootballTeam extends GameEntity {
  /// The corresponding player of this team.
  Player? player;

  /// Initial positions of pawns
  List<Vector> pawnsPositions;

  List<FootballPawn> pawns = [];

  int score = 0;
  bool _turn = false;
  bool winner = false;

  FootballTeam(this.player, ImageRenderer? image, this.pawnsPositions)
      : super(Vector(0, 0), const Size(0, 0), image: image) {
    for (Vector position in pawnsPositions) {
      pawns.add(FootballPawn(Vector(position.x, position.y), image));
    }
  }

  @override
  void render(Canvas canvas) {
    for (FootballPawn pawn in pawns) {
      pawn.render(canvas);
    }
  }

  @override
  void update(double dt) {
    for (FootballPawn pawn in pawns) {
      pawn.update(dt);
    }
  }

  @override
  bool contains(Offset position) => false;

  @override
  void reset() {
    for (var i = 0; i < pawnsPositions.length; ++i) {
      pawns[i].position = Vector(pawnsPositions[i].x, pawnsPositions[i].y);
      pawns[i].reset();
    }
    turn = false;
  }

  set turn(bool value) {
    _turn = value;
    for (FootballPawn pawn in pawns) {
      pawn.canMove = value;
    }
  }

  bool get turn => _turn;

  @override
  void handleGesture(Offset position, Gesture gesture) {
    if (!turn) return;
    for (FootballPawn pawn in pawns) {
      pawn.handleGesture(position, gesture);
    }
  }
}
