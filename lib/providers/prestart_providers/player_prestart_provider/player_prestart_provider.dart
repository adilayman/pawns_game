import 'package:flutter/material.dart';

import 'package:pawns_game/providers/application_providers/application.dart';
import 'package:pawns_game/providers/prestart_providers/player_prestart_provider/existing_player_provider.dart';
import 'package:pawns_game/providers/prestart_providers/player_prestart_provider/new_player_provider/new_player_model.dart';

enum PlayerPrestartState { Home, ExistingPlayer, NewPlayer }

class PlayerPrestartProvider extends ChangeNotifier {
  PlayerPrestartState _state = PlayerPrestartState.Home;

  late NewPlayerProvider newPlayerProvider;
  late ExistingPlayerProvider existingPlayerProvider;

  PlayerPrestartProvider(Application app) {
    newPlayerProvider = NewPlayerProvider(app);
    existingPlayerProvider = ExistingPlayerProvider(app);
  }

  String? get name {
    if (_state == PlayerPrestartState.NewPlayer)
      return newPlayerProvider.name;
    else if (_state == PlayerPrestartState.ExistingPlayer)
      return existingPlayerProvider.name;
    else
      return "";
  }

  String? get avatar {
    if (_state == PlayerPrestartState.NewPlayer)
      return newPlayerProvider.avatar;
    else if (_state == PlayerPrestartState.ExistingPlayer)
      return existingPlayerProvider.avatar;
    else
      return "";
  }

  set state(PlayerPrestartState value) {
    _state = value;
    notifyListeners();
  }

  PlayerPrestartState get state => _state;
}
