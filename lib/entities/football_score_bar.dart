import 'package:flutter/material.dart';
import 'package:pawns_game/entities/circular_progress_bar.dart';

import 'package:pawns_game/providers/football_mode_provider.dart';
import 'package:pawns_game/entities/football_team.dart';
import 'package:pawns_game/entities/text_area.dart';

import 'package:gamez/gamez.dart';

class FootballScoreBar extends GameEntity {
  FootballModeProvider _game;

  late CircularProgressBar _firstProgressBar;
  late CircularProgressBar _secondProgressBar;

  /// max time for plating.
  double _maxTime = 30;

  FootballScoreBar(Size size, this._game) : super(Vector(0, 0), size) {
    _firstProgressBar = _createProgressBar(
        Vector(size.width * 0.25, size.height / 2), _game.firstTeam);
    _secondProgressBar = _createProgressBar(
        Vector(size.width * 0.75, size.height / 2), _game.secondTeam);
  }

  /// Creates a circular progress bar given a [team].
  CircularProgressBar _createProgressBar(Vector position, FootballTeam team) {
    return CircularProgressBar(position, size.height * 0.4, _maxTime,
        image: _game.app.sprites[team.player!.avatar]);
  }

  /// Renders score bar background.
  void _renderScoreBarBackground(Canvas canvas) {
    Paint paint = Paint()..color = Color.fromRGBO(225, 255, 225, 0.25);
    canvas.drawRect(position.toOffset & size, paint);
  }

  /// Renders score background area.
  void _renderScoreArea(Canvas canvas, Offset position) {
    Paint paint = Paint()..color = Colors.white;

    Size size = Size(40, 40);
    canvas.drawRect(
      Offset(position.dx - size.width / 2, position.dy - size.height / 2) &
          size,
      paint,
    );
  }

  /// Renders score text given a [team].
  void _renderScoreText(Canvas canvas, Offset position, FootballTeam team) {
    TextSpan span = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'GearUp'),
      text: team.score.toString(),
    );
    TextPainter textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(position.dx - textPainter.size.width / 2,
          position.dy - textPainter.size.height / 2),
    );
  }

  /// Renders goal text.
  void _renderGoalText(Canvas canvas) {
    TextArea(Vector(size.width / 2, size.height / 2), "GOAL!!", fontSize: 38)
        .render(canvas);
  }

  /// Renders winner name.
  void _renderWinnerName(Canvas canvas) {
    String winnerName = _game.firstTeam.winner
        ? _game.firstTeam.player!.name
        : _game.secondTeam.player!.name;

    TextArea(
      Vector(size.width / 2, size.height / 2),
      "$winnerName WINS",
      fontSize: 38,
    ).render(canvas);
  }

  /// Renders a score given a [team].
  void _renderScore(Canvas canvas, Offset position, FootballTeam team) {
    _renderScoreArea(canvas, position);
    _renderScoreText(canvas, position, team);
  }

  /// Renders players' avatars.
  void _renderAvatars(Canvas canvas) {
    if (_game.firstTeam.winner || !_game.gameOver)
      _firstProgressBar.render(canvas);

    if (_game.secondTeam.winner || !_game.gameOver)
      _secondProgressBar.render(canvas);
  }

  /// Renders both teams' scores.
  void _renderScores(Canvas canvas) {
    // we're not rendering scores when the game ends or when a goal is scored.
    if (_game.gameOver || _game.goalSystem.goal) return;

    _renderScore(
        canvas, Offset(size.width * 0.35, size.height / 2), _game.firstTeam);
    _renderScore(
        canvas, Offset(size.width * 0.65, size.height / 2), _game.secondTeam);
  }

  @override
  void render(Canvas canvas) {
    _renderScoreBarBackground(canvas);
    _renderScores(canvas);
    _renderAvatars(canvas);

    if (_game.goalSystem.goal && !_game.gameOver) _renderGoalText(canvas);
    if (_game.gameOver) _renderWinnerName(canvas);
  }

  @override
  void update(double dt) {
    _game.firstTeam.turn
        ? _firstProgressBar.current += dt
        : _secondProgressBar.current += dt;

    if (_firstProgressBar.current >= _maxTime ||
        _secondProgressBar.current >= _maxTime) _game.nextRound();
  }

  @override
  bool contains(Offset position) => false;

  @override
  void reset() {
    _firstProgressBar.current = 0;
    _secondProgressBar.current = 0;
  }

  @override
  void handleGesture(Offset position, Gesture gesture) {}
}
