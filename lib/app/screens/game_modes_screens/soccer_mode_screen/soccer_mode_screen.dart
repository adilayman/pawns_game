import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_mode.dart';
import 'package:info2051_2018/core/screens/game_screen.dart';

// ignore: must_be_immutable
class SoccerModeView extends GameView {
  SoccerModeView()
      : super(game: SoccerMode(), backgroundColor: Colors.lightGreenAccent);
}
