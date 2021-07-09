import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/ball.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/score_bar.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_fields/soccer_field.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_team.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/pawn.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/core/utils/collision.dart';
import 'package:info2051_2018/core/utils/image_loader.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class SoccerMode extends Game {
  SoccerField field;
  ScoreBar _scoreBar;

  SoccerTeam _firstTeam;
  SoccerTeam _secondTeam;

  Ball _ball;

  ImageLoader _backgroundImage;
  ImageLoader _goalImage;

  ImageLoader _ballImage;

  Pawn movingPawn;

  SoccerMode() {
    _firstTeam = SoccerTeam(this, "lib/app/images/pawns/red_pawn.png");
    _secondTeam = SoccerTeam(this, "lib/app/images/pawns/blue_pawn.png");

    //entities.addAll(_firstTeam.pawns);
    //entities.addAll(_secondTeam.pawns);
    addEntity(_firstTeam);

    _backgroundImage = ImageLoader(
        "lib/app/images/backgrounds/soccer_background.png",
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

  @override
  void init(Size size) {
    super.init(size);
    Size scoreBarSize = Size(size.width, size.height * 0.2);

    _scoreBar = ScoreBar(Vector(0, 0), scoreBarSize);

    field = SoccerField(
      Vector(size.width * 0.075, size.height * 0.2),
      Size(size.width - 2 * size.width * 0.075,
          size.height - scoreBarSize.height),
    );

    _ball = Ball(Vector(100, 100), this);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (movingPawn != null) {
      _firstTeam.pawns.forEach((entity) {
        if (!identical(movingPawn, entity)) {
          _pawnPawnCollision(entity);
        }
      });

      _firstTeam.pawns.forEach((pawn) {
        _pawnFieldCollision(pawn);
      });

      movingPawn = null;
    }
  }

  void _pawnPawnCollision(Pawn pawn) {
    if (circleCollision(movingPawn, pawn)) {
      double dx = movingPawn.x - pawn.x;
      double dy = movingPawn.y - pawn.y;

      double nl = sqrt(dx * dx + dy * dy);

      var nx = -dx / nl;
      var ny = -dy / nl;
      // calcunew velocity: v' = v - 2 * dot(d, v) * n
      double dot = movingPawn.velocity.x * nx + movingPawn.velocity.y * ny;
      movingPawn.velocity.x -= 2 * dot * nx;
      movingPawn.velocity.y -= 2 * dot * ny;

      pawn.velocity.x += dot * nx;
      pawn.velocity.y += dot * ny;

      pawn.frames = 5;
      pawn.moving = true;

      movingPawn.frames = 5;
    }
  }

  void _pawnFieldCollision(Pawn pawn) {
    if (pawn.x - pawn.radius <= field.topLeft.x &&
        !(pawn.y - pawn.radius >= size.height * 0.4 &&
            pawn.y + pawn.radius <= size.height * 0.4 + size.height * 0.4)) {
      pawn.x = field.topLeft.x + pawn.radius;
      pawn.velocity.x *= -1;
    }

    if (pawn.x + pawn.radius >= field.topRight.x) {
      pawn.x = field.topRight.x - pawn.radius;
      pawn.velocity.x *= -1;
    }

    if (pawn.y - pawn.radius <= field.topLeft.y) {
      pawn.y = field.topLeft.y + pawn.radius;
      pawn.velocity.y *= -1;
    }

    if (pawn.y + pawn.radius >= field.bottomRight.y) {
      pawn.y = field.bottomRight.y - pawn.radius;
      pawn.velocity.y *= -1;
    }

    if (pawn.x - pawn.radius <= 0) {
      pawn.x = pawn.radius;
      pawn.velocity.x *= -1;
    }
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
