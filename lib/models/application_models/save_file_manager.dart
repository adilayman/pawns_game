import 'dart:io';

import 'package:gamez/gamez.dart';
import 'package:pawns_game/models/application_models/player.dart';

class SaveFileManager {
  FileManager _fileManager;
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
      List<String> splitedLine = line.split(" ");

      if (splitedLine.length != _numberInformation) continue;

      // create a new player instance.
      _players[splitedLine[0]] = Player(
        splitedLine[0],
        splitedLine[1],
        int.parse(splitedLine[2]),
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
