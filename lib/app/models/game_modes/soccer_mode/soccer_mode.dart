import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/score_bar.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_fields/soccer_field.dart';
import 'package:info2051_2018/app/models/pawn.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class SoccerMode extends Game {
  late SoccerField field;
  late ScoreBar _scoreBar;

  SoccerMode() {
    addEntity(Pawn(Vector(430, 200), Colors.red.shade900, this));

    addEntity(Pawn(Vector(500, 200), Colors.blue.shade900, this));
    //addEntity(Pawn(Vector(580, 100), Colors.blue.shade900, this));
  }

  @override
  void init(Size size) {
    super.init(size);
    Size scoreBarSize = Size(size.width, size.height * 0.2);

    _scoreBar = ScoreBar(Vector(0, 0), scoreBarSize);

    field = SoccerField(
      Vector(size.width * 0.1, size.height * 0.2),
      Size(size.width - size.width * 0.2, size.height - scoreBarSize.height),
    );
  }

  @override
  void render(Canvas canvas, Size size) {
    _scoreBar.render(canvas);
    field.render(canvas);
    super.render(canvas, size);
  }
}
