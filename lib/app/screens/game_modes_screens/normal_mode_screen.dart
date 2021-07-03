import 'package:flutter/material.dart';
import 'package:info2051_2018/app/models/game_modes/normal_mode.dart';
import 'package:info2051_2018/core/screens/game_screen.dart';

// ignore: must_be_immutable
class NormalModeView extends GameView {
  NormalModeView()
      : super(game: NormalMode(), backgroundColor: Colors.lightGreenAccent);
}
