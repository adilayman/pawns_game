import 'package:flutter/material.dart';
import 'package:gamez/gamez.dart';
import 'package:pawns_game/providers/football_mode_provider.dart';

class FootballField extends GameEntity {
  FootballModeProvider _game;

  ImageRenderer? _leftGoalSprite;
  ImageRenderer? _rightGoalSprite;

  FootballField(Vector position, Size size, this._game)
      : super(position, size) {
    _loadSpritesGoals();
  }

  /// Loads the two goals' sprites.
  void _loadSpritesGoals() {
    _leftGoalSprite =
        _game.app.sprites["assets/png/football_mode/left_goal.png"];
    _rightGoalSprite =
        _game.app.sprites["assets/png/football_mode/right_goal.png"];
  }

  /// Renders field borders.
  void _renderBorders(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    Rect borders = Rect.fromLTWH(left, position.y + paint.strokeWidth / 2,
        size.width, size.height - paint.strokeWidth / 2);

    RRect rrectBorders = RRect.fromRectAndRadius(borders, Radius.circular(0));

    canvas.drawRRect(rrectBorders, paint);

    canvas.drawLine(Offset(left + size.width / 2, top),
        Offset(left + size.width / 2, bottom), paint);

    canvas.drawCircle(center.toOffset, 5, paint);
  }

  /// Renders goals.
  void renderGoals(Canvas canvas) {
    _leftGoalSprite!.render(canvas, Offset(0, goalSize.height), goalSize);
    _rightGoalSprite!.render(canvas,
        Offset(_game.size.width - goalSize.width, goalSize.height), goalSize);
  }

  /// Render field's background.
  void _renderFieldBackground(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(0, 0, 0, 0.25);
    canvas.drawRect(position.toOffset & size, paint);
  }

  @override
  void render(Canvas canvas) {
    _renderFieldBackground(canvas);
    _renderBorders(canvas);
  }

  @override
  bool contains(Offset position) => false;

  double get left => position.x;

  double get top => position.y;

  double get right => position.x + size.width;

  double get bottom => position.y + size.height;

  Vector get center => Vector(x + size.width / 2, y + size.height / 2);

  Size get goalSize => Size(_game.size.width * 0.075, _game.size.height * 0.4);

  @override
  void reset() {}

  @override
  void update(double dt) {}

  @override
  void handleGesture(Offset position, Gesture gesture) {}
}
