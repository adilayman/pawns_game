import 'package:flutter/material.dart';

import 'package:pawns_game/providers/application.dart';
import 'package:pawns_game/models/player.dart';
import 'package:pawns_game/providers/avatar_selection_provider.dart';

class NewPlayerProvider extends ChangeNotifier {
  final Application _app;

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
