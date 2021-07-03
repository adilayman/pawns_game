import 'package:flutter/material.dart';
import 'package:info2051_2018/core/models/game/game_ticker.dart';
import 'package:info2051_2018/core/models/game_entity/game_entity.dart';
import 'package:info2051_2018/core/utils/vector.dart';

abstract class Game with ChangeNotifier {
  late GameTicker _gameTicker;

  Vector collisionP = Vector(0, 0); // for tests

  late List<GameEntity> _entities = [];

  Game() {
    _gameTicker = GameTicker(update);
    _gameTicker.start();
  }

  /// update the game components at each frame
  void update(double dt) {
    int nUpdates = 0;
    entities.forEach((element) {
      if (element.update(dt)) nUpdates++;
    });
    if (nUpdates > 0) notifyListeners();
  }

  void render(Canvas canvas, Size size) {
    entities.forEach((element) => element.render(canvas));
  }

  void onLongPressMoveUpdate(Offset position) {
    entities.forEach((element) => element.onLongPressMoveUpdate(position));
  }

  /// perform each child procedure on long press start gesture
  void onLongPressStart(Offset position) {
    entities.forEach((element) => element.onLongPressStart(position));
  }

  /// perform each child procedure on long press end gesture
  void onLongPressEnd(Offset position) {
    entities.forEach((element) => element.onLongPressEnd(position));
  }

  /// add a new entity to the game
  void addEntity(GameEntity entity) {
    _entities.add(entity);
  }

  List<GameEntity> get entities => _entities;
}
