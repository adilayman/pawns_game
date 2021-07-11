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

    _ball = Ball(
        Vector(size.width * 0.075 + (size.width - 2 * size.width * 0.075) / 2,
            size.height * 0.2 + (size.height - scoreBarSize.height) / 2),
        this,
        collisionSys: collisionSystem);
    addEntity(_ball);

    _composition = SoccerComposition(
      Vector(size.width * 0.075, size.height * 0.2),
      Size(size.width - 2 * size.width * 0.075,
          size.height - scoreBarSize.height),
    );

    _firstTeam = SoccerTeam(this, "lib/app/images/pawns/red_pawn.png",
        _composition.defaultComposition(TeamSide.LeftSide),
        collisionSys: collisionSystem);

    _secondTeam = SoccerTeam(this, "lib/app/images/pawns/blue_pawn.png",
        _composition.defaultComposition(TeamSide.RightSide),
        collisionSys: collisionSystem);

    addEntity(_firstTeam);
    addEntity(_secondTeam);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_ball.x - _ball.radius / 2 <= field.topLeft.x &&
        (_ball.y - _ball.radius >= size.height * 0.4 &&
            _ball.y + _ball.radius <= size.height * 0.4 + size.height * 0.4)) {
      print("goal!!!");
    }

    super.update(dt);
  }

  void collisionSystem(CircleEntity first) {
    _firstTeam.pawns.forEach((second) {
      _pawnPawnCollision(first, second);
    });

    _secondTeam.pawns.forEach((second) {
      _pawnPawnCollision(first, second);
    });

    _pawnPawnCollision(first, _ball);
    _pawnFieldCollision(first);
  }

  bool _pawnPawnCollision(CircleEntity first, CircleEntity second) {
    if (identical(first, second)) return false;

    if (circleCollision(first, second)) {
      double dx = first.x - second.x;
      double dy = first.y - second.y;

      double nl = sqrt(dx * dx + dy * dy);

      var nx = -dx / nl;
      var ny = -dy / nl;
      // calcunew velocity: v' = v - 2 * dot(d, v) * n
      double dot = first.velocity.x * nx + first.velocity.y * ny;
      first.velocity.x -= 2 * dot * nx;
      first.velocity.y -= 2 * dot * ny;

      second.velocity.x += dot * nx;
      second.velocity.y += dot * ny;

      second.frames = 5;
      second.moving = true;

      first.frames = 5;
      first.moving = true;

      return true;
    }
    return false;
  }

  void _pawnFieldCollision(CircleEntity pawn) {
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
