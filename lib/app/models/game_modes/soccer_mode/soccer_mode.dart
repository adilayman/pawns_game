import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/score_bar.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_fields/soccer_field.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_team.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/core/utils/image_loader.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class SoccerMode extends Game {
  SoccerField field;
  ScoreBar _scoreBar;

  SoccerTeam _firstTeam;
  SoccerTeam _secondTeam;

  ImageLoader _backgroundImage;
  ImageLoader _goalImage;

  SoccerMode() {
    _firstTeam = SoccerTeam(this, "lib/app/images/pawns/red_pawn.png");
    _secondTeam = SoccerTeam(this, "lib/app/images/pawns/blue_pawn.png");

    addEntity(_firstTeam);
    addEntity(_secondTeam);

    _backgroundImage = ImageLoader(
        "lib/app/images/backgrounds/soccer_background.png",
        onLoad: onImageLoad);
    _backgroundImage.loadImage();

    _goalImage =
        ImageLoader("lib/app/images/soccer_mode/goal.png", onLoad: onImageLoad);
    _goalImage.loadImage();
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
