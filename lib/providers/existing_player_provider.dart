import 'package:flutter/material.dart';

import 'package:pawns_game/providers/application.dart';
import 'package:pawns_game/models/player.dart';

class ExistingPlayerProvider extends ChangeNotifier {
  List<Player> players = [];
  Player? _currentPlayer;

  Application _app;

  ExistingPlayerProvider(this._app) {
    players = _app.players.values.toList();
    if (players.length > 0) currentPlayer = players[0];
  }

  set currentPlayer(Player? player) {
    if (_currentPlayer == player) return;
    _currentPlayer = player;
    notifyListeners();
  }

  Player? get currentPlayer => _currentPlayer;

  String get name => _currentPlayer?.name ?? "";

  String get avatar => _currentPlayer?.avatar ?? "";

  int get wins => _currentPlayer?.wins ?? 0;
}
