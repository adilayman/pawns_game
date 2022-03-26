import 'dart:io';

import 'package:pawns_game/models/application_models/player.dart';
import 'package:pawns_game/resources/file_manager.dart';

class SaveFileManager {
  late FileManager _fileManager;
  String _filename;

  Map<String, Player> _players = Map<String, Player>();

  /// {name, avatar, wins}
  int _numberInformation = 3;

  SaveFileManager(this._filename);

  /// Create a new save file
  ///
  /// If the file already exists it will not be recreated.
  Future<void> _createSaveFile() async {
    String appDocumentsPath = await FileManager.getAppDocumentsPath();
    _fileManager = FileManager("$appDocumentsPath/$_filename");
    _fileManager.create();
  }

  Future<void> loadPlayers() async {
    await _createSaveFile();

    String content = _fileManager.read();

    // split lines; each line is a player information.
    List<String> lines = content.split("\n");

    for (String line in lines) {
      List<String> splitLine = line.split(" ");

      if (splitLine.length != _numberInformation) continue;

      // create a new player instance.
      _players[splitLine[0]] = Player(
        splitLine[0],
        splitLine[1],
        int.parse(splitLine[2]),
      );
    }
  }

  /// Updates the save file.
  void updateSaveFile() {
    // remove all data in the file.
    _fileManager.write("", mode: FileMode.write);

    // rewrite the map in the file.
    for (Player player in _players.values)
      _fileManager.write("${player.name} ${player.avatar} ${player.wins}\n");
  }

  /// Adds a new player to the save file.
  void addPlayer(Player player) {
    _players[player.name] = player;
    _fileManager.write("${player.name} ${player.avatar} 0\n");
  }

  /// All created players.
  Map<String, Player> get players => _players;
}
