import 'package:gamez/gamez.dart';

class SpritesManager {
  Map<String, Sprite> _sprites = Map<String, Sprite>();

  SpritesManager() {
    /// football mode sprites
    _createSprite("assets/png/football_mode/left_goal.png");
    _createSprite("assets/png/football_mode/right_goal.png");
    _createSprite("assets/png/football_mode/football.png");

    /// pawns' sprites
    _createSprite("assets/png/pawns/blue_pawn.png");
    _createSprite("assets/png/pawns/red_pawn.png");

    _createSprite("assets/png/trophy.png");

    _createSprite("assets/png/app_logo.png");

    // avatars sprites
    for (var i = 1; i <= 18; ++i)
      _createSprite("assets/png/avatars/avatar_$i.png");
  }

  /// Creates a new sprites.
  void _createSprite(String pathname) => _sprites[pathname] = Sprite(pathname);

  /// Loads all sprites.
  Future<void> loadSprites() async {
    for (Sprite sprite in _sprites.values) await sprite.load();
  }

  /// All loaded sprites.
  Map<String, Sprite> get sprites => _sprites;
}
