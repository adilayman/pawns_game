import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/ball.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/score_bar.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_composition.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_fields/soccer_field.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_entities/soccer_team.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_entities/pawn.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/core/models/game_entity/circle_entity.dart';
import 'package:info2051_2018/core/utils/collision.dart';
import 'package:info2051_2018/core/utils/image_loader.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class SoccerMode extends Game {
  SoccerField field;
  ScoreBar _scoreBar;

  SoccerTeam _firstTeam;
  SoccerTeam _secondTeam;

  SoccerComposition _composition;

  Ball _ball;

  ImageLoader _backgroundImage;
  ImageLoader _goalImage;

  ImageLoader _ballImage;

  Pawn movingPawn;

  SoccerMode() {
    //entities.addAll(_firstTeam.pawns);
    //entities.addAll(_secondTeam.pawns);

    _backgroundImage = ImageLoader(
        "lib/app/images/backgrounds/soccer_background_1.png",
        onLoad: onImageLoad);
    _backgroundImage.loadImage();

    _goalImage =
        ImageLoader("lib/app/images/soccer_mode/goal.png", onLoad: onImageLoad);
    _goalImage.loadImage();

    // _ballImage =
    //     ImageLoader("lib/app/images/ball_soccer.png", onLoad: onImageLoad);
    // _ballImage.loadImage();
  }

  void onImageLoad() {
    requestUpdate();
    print("loaded");
  }

  void _createSoccerField(Size scoreBarSize) {
    field = SoccerField(
      Vector(size.width * 0.075, size.height * 0.2),
      Size(size.width - 2 * size.width * 0.075,
          size.height - scoreBarSize.height),
    );
  }

  void _createScoreBar(Size scoreBarSize) {
    _scoreBar = ScoreBar(Vector.zero, scoreBarSize);
  }

  void _createSoccerBall(Size scoreBarSize) {
    _ball = Ball(Vector(
        size.width * 0.075 + (size.width - 2 * size.width * 0.075) / 2,
        size.height * 0.2 + (size.height - scoreBarSize.height) / 2));
    addEntity(_ball);
  }

  @override
  void init(Size size) {
    super.init(size);
    Size scoreBarSize = Size(size.width, size.height * 0.2);

    _createScoreBar(scoreBarSize);

    _createSoccerField(scoreBarSize);

    _createSoccerBall(scoreBarSize);

    _composition = SoccerComposition(
      Vector(size.width * 0.075, size.height * 0.2),
      Size(size.width - 2 * size.width * 0.075,
          size.height - scoreBarSize.height),
    );

    _firstTeam = SoccerTeam("lib/app/images/pawns/red_pawn.png",
        _composition.defaultComposition(TeamSide.LeftSide));

    _secondTeam = SoccerTeam("lib/app/images/pawns/blue_pawn.png",
        _composition.defaultComposition(TeamSide.RightSide));

    addEntity(_firstTeam);
    addEntity(_secondTeam);
  }

  @override
  void update(double dt) {
    super.update(dt);

    List<Pawn> pawns = [];

    pawns.addAll(_firstTeam.pawns);
    pawns.addAll(_secondTeam.pawns);

    for (int i = 0; i < pawns.length; i++) {
      for (int j = i + 1; j < pawns.length; j++) {
        _pawnPawnCollision(pawns[i], pawns[j], dt);
      }
      _pawnPawnCollision(pawns[i], _ball, dt);
      _pawnFieldCollision(pawns[i]);
    }

    _ballFieldCollision(_ball);

    if (_ball.x - _ball.radius / 2 <= field.topLeft.x &&
        (_ball.y - _ball.radius >= size.height * 0.4 &&
            _ball.y + _ball.radius <= size.height * 0.4 + size.height * 0.4)) {
      print("goal!!!");
    }

    _scoreBar.firstAvatar.currentValue += dt;
  }

  bool _pawnPawnCollision(CircleEntity first, CircleEntity second, double dt) {
    if (identical(first, second)) return false;

    if (circleCollision(first, second)) {
      resolveCircle(first, second);
      double dx = first.x - second.x;
      double dy = first.y - second.y;

      double nl = sqrt(dx * dx + dy * dy);

      var nx = -dx / nl;
      var ny = -dy / nl;
      // calcunew velocity: v' = v - 2 * dot(d, v) * n
      double dot;

      if (first.moving) {
        dot = first.velocity.x * nx + first.velocity.y * ny;
        first.velocity.x -= dot * nx;
        first.velocity.y -= dot * ny;
        second.velocity.x += dot * nx;
        second.velocity.y += dot * ny;
      } else {
        dot = second.velocity.x * nx + second.velocity.y * ny;
        first.velocity.x += dot * nx;
        first.velocity.y += dot * ny;
        second.velocity.x -= dot * nx;
        second.velocity.y -= dot * ny;
      }

      second.frames = 5;
      second.moving = true;

      first.frames = 5;
      first.moving = true;

      return true;
    }
    return false;
  }

  void _fieldCollisionTB(CircleEntity circle) {
    if (circle.y - circle.radius <= field.topLeft.y) {
      circle.y = field.topLeft.y + circle.radius;
      circle.velocity.y *= -1;
    }

    if (circle.y + circle.radius >= field.bottomRight.y) {
      circle.y = field.bottomRight.y - circle.radius;
      circle.velocity.y *= -1;
    }
  }

  void _pawnFieldCollisionLR(Pawn circle) {
    if (circle.x - circle.radius <= field.topLeft.x) {
      circle.x = field.topLeft.x + circle.radius;
      circle.velocity.x *= -1;
    }

    if (circle.x + circle.radius >= field.topRight.x) {
      circle.x = field.topRight.x - circle.radius;
      circle.velocity.x *= -1;
    }
  }

  void _ballFieldCollisionLR(Ball ball) {
    if (ball.x - ball.radius <= field.topLeft.x &&
        !(ball.y - ball.radius >= size.height * 0.4 &&
            ball.y <= size.height * 0.4 + size.height * 0.4)) {
      ball.x = field.topLeft.x + ball.radius;
      ball.velocity.x *= -1;
    }

    if (ball.x + ball.radius >= field.topRight.x) {
      ball.x = field.topRight.x - ball.radius;
      ball.velocity.x *= -1;
    }
  }

  void _pawnFieldCollision(Pawn pawn) {
    _pawnFieldCollisionLR(pawn);
    _fieldCollisionTB(pawn);
  }

  void _ballFieldCollision(Ball ball) {
    _ballFieldCollisionLR(ball);
    _fieldCollisionTB(ball);
  }

  @override
  void render(Canvas canvas, Size size) {
    if (_backgroundImage.isLoaded) {
      canvas.drawImageRect(
        _backgroundImage.image,
        Rect.fromLTWH(0, 0, _backgroundImage.image.width.toDouble(),
            _backgroundImage.image.height.toDouble()),
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint(),
      );
    }

    _scoreBar.render(canvas);
    field.render(canvas);

    super.render(canvas, size);

    canvas.save();

    //canvas.skew(-1, -1);

    if (_goalImage.isLoaded) {
      canvas.drawImageRect(
        _goalImage.image,
        Rect.fromLTWH(0, 0, _goalImage.image.width.toDouble(),
            _goalImage.image.height.toDouble()),
        Rect.fromLTWH(
            0, size.height * 0.4, size.width * 0.075, size.height * 0.4),
        Paint(),
      );
    }
    canvas.restore();
  }
}
