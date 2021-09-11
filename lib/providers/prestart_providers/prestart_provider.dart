import 'package:flutter/material.dart';

import 'package:pawns_game/providers/application_providers/application.dart';
import 'package:pawns_game/providers/prestart_providers/player_prestart_provider/player_prestart_provider.dart';

class PrestartProvider extends ChangeNotifier {
  Application _app;

  PlayerPrestartProvider firstPlayerProvider;
  PlayerPrestartProvider secondPlayerProvider;

  PrestartProvider(this._app) {
    firstPlayerProvider = PlayerPrestartProvider(_app);
    secondPlayerProvider = PlayerPrestartProvider(_app);
  }

  /// Verifies players inputs.
  void verifyPlayersInfo() {
    _verifyNames();

    if (firstPlayerProvider.state == PlayerPrestartState.NewPlayer)
      firstPlayerProvider.newPlayerProvider.createNewPlayer();

    if (secondPlayerProvider.state == PlayerPrestartState.NewPlayer)
      secondPlayerProvider.newPlayerProvider.createNewPlayer();

    // Save selected players.
    _app.firstPlayer = _app.players[firstPlayerProvider.name];
    _app.secondPlayer = _app.players[secondPlayerProvider.name];
  }

  /// Verify players' names input.
  void _verifyNames() {
    if (!_validName(firstPlayerProvider.name) ||
        !_validName(secondPlayerProvider.name))
      throw "You have to choose two players before starting!";

    if (firstPlayerProvider.name == secondPlayerProvider.name)
      throw "You have to choose different players!";
  }

  /// Checks the validy of a given [name].
  bool _validName(String name) => name != null && name.isNotEmpty;
}
