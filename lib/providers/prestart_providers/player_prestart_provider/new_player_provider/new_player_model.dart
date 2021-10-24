import 'package:flutter/material.dart';

import 'package:pawns_game/providers/application_providers/application.dart';
import 'package:pawns_game/models/application_models/player.dart';
import 'package:pawns_game/providers/prestart_providers/player_prestart_provider/new_player_provider/avatar_selection_provider.dart';

class NewPlayerProvider extends ChangeNotifier {
  Application _app;

  late AvatarSelectionProvider _avatarSelectionProvider;
  String name = "";

  NewPlayerProvider(this._app) {
    _avatarSelectionProvider = AvatarSelectionProvider(_app);
  }

  /// Creates a new player.
  void createNewPlayer() {
    if (_app.players[name] != null) throw "The player \"$name\" already exists";
    _app.addPlayer(Player(name, avatar, 0));
  }

  String get avatar => _avatarSelectionProvider.selectedAvatar!.pathname;

  AvatarSelectionProvider get avatarSelectionProvider =>
      _avatarSelectionProvider;
}
