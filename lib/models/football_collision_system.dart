import 'package:pawns_game/providers/football_mode_provider.dart';
import 'package:pawns_game/entities/football.dart';
import 'package:pawns_game/entities/football_pawn.dart';

import 'package:gamez/gamez.dart';

/// Football mode collision system
class FootballCollisionSystem {
  final FootballModeProvider _game;

  FootballCollisionSystem(this._game);

  void perform() {
    List<FootballPawn> pawns = [];
    pawns.addAll(_game.firstTeam.pawns);
    pawns.addAll(_game.secondTeam.pawns);

    for (int i = 0; i < pawns.length; i++) {
      for (int j = i + 1; j < pawns.length; j++) {
        _circleCircleBounce(pawns[i], pawns[j]);
      }

      // pawn-ball bouncing
      _circleCircleBounce(pawns[i], _game.ball);

      _pawnFieldBounce(pawns[i]);
    }

    _ballFieldBounce(_game.ball);
  }

  /// Performs circle-circle bouncing.
  void _circleCircleBounce(CircularEntity first, CircularEntity second) {
    if (identical(first, second) || !_circleCollision(first, second)) return;

    Vector collision = Vector(second.x - first.x, second.y - first.y);

    Vector relativeVelocity = first.velocity - second.velocity;

    double distance = first.position.distance(second.position);

    Vector collisionNorm = collision / distance;

    double speed = collisionNorm.dot(relativeVelocity);

    if (speed < 0) return;

    first.velocity.x -= speed * collisionNorm.x;
    first.velocity.y -= speed * collisionNorm.y;

    second.velocity.x += speed * collisionNorm.x;
    second.velocity.y += speed * collisionNorm.y;
  }

  /// Performs circle-field top-bottom bouncing.
  void _circleFieldBounceTB(CircularEntity circular) {
    if (circular.y - circular.radius <= _game.field.position.y) {
      circular.y = _game.field.position.y + circular.radius;
      circular.velocity.y *= -1;
    }

    if (circular.y + circular.radius >= _game.field.bottom) {
      circular.y = _game.field.bottom - circular.radius;
      circular.velocity.y *= -1;
    }
  }

  /// Performs pawn-field left-right bouncing.
  void _pawnFieldBounceLR(FootballPawn circular) {
    if (circular.x - circular.radius <= _game.field.left) {
      circular.x = _game.field.left + circular.radius;
      circular.velocity.x *= -1;
    }

    if (circular.x + circular.radius >= _game.field.right) {
      circular.x = _game.field.right - circular.radius;
      circular.velocity.x *= -1;
    }
  }

  /// Performs pawn-field bouncing.
  void _pawnFieldBounce(FootballPawn pawn) {
    _pawnFieldBounceLR(pawn);
    _circleFieldBounceTB(pawn);
  }

  /// Performs ball-field left-right bouncing.
  void _ballFieldBounceLR(Football ball) {
    if (ball.x - ball.radius <= _game.field.left && !_ballInOrdinateGoal()) {
      ball.x = _game.field.left + ball.radius;
      ball.velocity.x *= -1;
    }

    if (ball.x + ball.radius >= _game.field.right && !_ballInOrdinateGoal()) {
      ball.x = _game.field.right - ball.radius;
      ball.velocity.x *= -1;
    }
  }

  /// Performs ball-field boucning.
  void _ballFieldBounce(Football ball) {
    _ballFieldBounceLR(ball);
    _circleFieldBounceTB(ball);
  }

  /// Checks if the ball is between in the ordinate positions of the goal.
  bool _ballInOrdinateGoal() {
    return _game.ball.y - _game.ball.radius >= _game.field.goalSize.height &&
        _game.ball.y + _game.ball.radius <= 2 * _game.field.goalSize.height;
  }

  /// Checks if [c1] and [c2] collides.
  bool _circleCollision(CircularEntity c1, CircularEntity c2) {
    double dx = c1.x - c2.x;
    double dy = c1.y - c2.y;
    return dx * dx + dy * dy <=
        (c1.radius + c2.radius) * (c1.radius + c2.radius);
  }
}
