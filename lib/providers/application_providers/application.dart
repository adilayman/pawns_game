import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamez/gamez.dart';
import 'package:pawns_game/models/application_models/player.dart';
import 'package:pawns_game/models/application_models/save_file_manager.dart';
import 'package:pawns_game/models/application_models/sprites_manager.dart';

class Application extends ChangeNotifier {
  Player? firstPlayer;
  Player? secondPlayer;

  SpritesManager _spritesManager = SpritesManager();
  SaveFileManager _saveFileManager = SaveFileManager("save.txt");

  List<Color> standardGradient = [
    Color.fromRGBO(50, 91, 125, 1),
    Color.fromRGBO(100, 91, 125, 1),
    Color.fromRGBO(150, 91, 125, 1)
  ];

  /// Loads all necessary resources for the application.
  Future<void> loading() async {
    await _spritesManager.loadSprites();
    await _saveFileManager.loadPlayers();
  }

  /// Adds a new player to the save file.
  void addPlayer(Player player) => _saveFileManager.addPlayer(player);

  /// Updates the save file.
  void updateSaveFile() => _saveFileManager.updateSaveFile();

  /// All created players.
  Map<String, Player> get players => _saveFileManager.players;

  /// All loaded sprites.
  Map<String, ImageRenderer> get sprites => _spritesManager.sprites;
}
