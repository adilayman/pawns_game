import 'package:flutter/material.dart';

import 'package:pawns_game/core/models/game/game_loop.dart';
import 'package:pawns_game/core/models/game_entities/game_entity.dart';
import 'package:pawns_game/core/models/game/game_gesture.dart';

/// Abstract representation of a game.
abstract class Game extends ChangeNotifier implements GameGesture {
  Size _size = Size.zero;

  GameLoop _gameLoop;
  List<GameEntity> _entities = [];

  BuildContext _context;

  bool gameOver = false;

  bool _isInit = false;

  /// Creates a new game.
  Game() {
    _gameLoop = GameLoop(update);
    _gameLoop.start();
  }

  /// Init the game given the [context].
  void init(BuildContext context) {
    this._context = context;
    this._size = MediaQuery.of(context).size;
    _isInit = true;
  }

  /// Updates the game entities at each frame.
  void update(double dt) {
    for (GameEntity entity in entities) entity.update(dt);
    notifyListeners(); // notify to update the rendering
  }

  /// Renders the game.
  void render(Canvas canvas, Size size) {
    for (GameEntity entity in entities) entity.render(canvas);
  }

  /// Adds a new entity.
  void addEntity(GameEntity entity) => _entities.add(entity);

  /// Resets the game state.
  void reset();

  void onLongPressMoveUpdate(Offset position) {
    for (GameEntity entity in entities) entity.onLongPressMoveUpdate(position);
  }

  void onLongPressStart(Offset position) {
    for (GameEntity entity in entities) entity.onLongPressStart(position);
  }

  void onLongPressEnd(Offset position) {
    for (GameEntity entity in entities) entity.onLongPressEnd(position);
  }

  List<GameEntity> get entities => _entities;

  GameLoop get gameLoop => _gameLoop;

  Size get size => _size;

  BuildContext get context => _context;

  bool get isInit => _isInit;
}
