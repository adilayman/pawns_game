import 'package:flutter/material.dart';

import 'package:pawns_game/providers/application.dart';
import 'package:pawns_game/providers/existing_player_provider.dart';
import 'package:pawns_game/providers/new_player_model.dart';

enum PlayerPrestartState { home, existingPlayer, newPlayer }

class PlayerPrestartProvider extends ChangeNotifier {
  PlayerPrestartState _state = PlayerPrestartState.home;

  late NewPlayerProvider newPlayerProvider;
  late ExistingPlayerProvider existingPlayerProvider;

  PlayerPrestartProvider(Application app) {
    newPlayerProvider = NewPlayerProvider(app);
    existingPlayerProvider = ExistingPlayerProvider(app);
  }

  String? get name {
    if (_state == PlayerPrestartState.newPlayer) {
      return newPlayerProvider.name;
    } else if (_state == PlayerPrestartState.existingPlayer) {
      return existingPlayerProvider.name;
    } else {
      return "";
    }
  }

  String? get avatar {
    if (_state == PlayerPrestartState.newPlayer) {
      return newPlayerProvider.avatar;
    } else if (_state == PlayerPrestartState.existingPlayer) {
      return existingPlayerProvider.avatar;
    } else {
      return "";
    }
  }

  set state(PlayerPrestartState value) {
    _state = value;
    notifyListeners();
  }

  PlayerPrestartState get state => _state;
}
