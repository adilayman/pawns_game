import 'package:flutter/material.dart';
import 'package:pawns_game/providers/application.dart';

import 'package:pawns_game/providers/football_mode_provider.dart';
import 'package:pawns_game/widgets/standard_widgets/app_icon_button.dart';

import 'package:gamez/gamez.dart';

// ignore: must_be_immutable
class FootballModeScreen extends GameWidget {
  FootballModeScreen(Application app, {Key? key})
      : super(key: key, game: FootballModeProvider(app)) {
    _createQuitButton();
  }

  /// Adds a quit button to the game screen.
  void _createQuitButton() {
    addChild(
      AppIconButton(
        onPressed: () {
          game.gameLoop.stop();
          Navigator.pushNamed(game.context, "/home");
        },
        icon: Icons.power_settings_new,
        primaryColor: Colors.red.shade500,
        secondaryColor: const Color.fromRGBO(0, 5, 25, 0.25),
      ),
    );
  }
}
