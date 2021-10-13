import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:pawns_game/providers/application_providers/application.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/football_composition.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/game_entities/football.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/game_entities/football_pawn.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/game_entities/football_team.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/game_systems/football_collision_system.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/game_systems/football_goal_system.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/render_elements/football_field.dart';
import 'package:pawns_game/models/game_mode_models/football_mode_models/render_elements/football_score_bar.dart';

import 'package:gamez/gamez.dart';

class FootballModeProvider extends Game {
  /// football field renderer.
  late FootballField _field;

  /// football score bar renderer.
  late FootballScoreBar _scoreBar;

  /// current composition for both teams
  late FootballComposition _composition;

  late FootballTeam _firstTeam;
  late FootballTeam _secondTeam;
  late Football _ball;

  late FootballCollisionSystem _collisionSystem;
  late FootballGoalSystem _goalSystem;

  late BuildContext context;
  late Application app;

  FootballModeProvider(this.context, this.app) {
    _createAllRenders();
    _collisionSystem = FootballCollisionSystem(this);
    _goalSystem = FootballGoalSystem(this);
  }

  @override
  void reset() {
    for (GameEntity entity in entities) entity.reset();
    _ball.position = _field.center.clone;
    _scoreBar.reset();
  }

  /// Checks if at least one pawn in [team] is pressed.
  bool _isPressed(FootballTeam team) {
    if (!team.turn) return false;
    bool pressed = false;
    for (FootballPawn pawn in team.pawns) if (pawn.startPress) pressed = true;
    return pressed;
  }

  @override
  void onLongPressEnd(Offset position) {
    // we only switch sides if a pawn is already pressed.
    bool switchSides = _isPressed(_firstTeam) || _isPressed(_secondTeam);
    super.onLongPressEnd(position);
    if (switchSides) nextRound();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _collisionSystem.perform();
    _goalSystem.perform();
    _scoreBar.update(dt);
  }

  /// Renders the background color.
  void _renderBackground(Canvas canvas) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        app.standardGradient,
        [0, 0.5, 0.75],
      );

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  void render(Canvas canvas, Size size) {
    _renderBackground(canvas);
    _field.render(canvas);
    _scoreBar.render(canvas);
    super.render(canvas, size);
    _field.renderGoals(canvas);
  }

  /// Creates all render elements.
  void _createAllRenders() {
    Size scoreBarSize = Size(size.width, size.height * 0.2);
    _createFootball(scoreBarSize);
    _createFootballField(scoreBarSize);
    _createFootballTeams();
    _createScoreBar(scoreBarSize);
  }

  /// Creates the football field.
  void _createFootballField(Size scoreBarSize) {
    Vector fieldPosition = Vector(size.width * 0.075, scoreBarSize.height);
    Size fieldSize = Size(
      size.width - 2 * size.width * 0.075,
      size.height - scoreBarSize.height,
    );
    _field = FootballField(fieldPosition, fieldSize, this);
  }

  /// Creates the score bar.
  void _createScoreBar(Size scoreBarSize) =>
      _scoreBar = FootballScoreBar(scoreBarSize, this);

  /// Creates the football.
  void _createFootball(Size scoreBarSize) {
    _ball = Football(
      Vector(size.width / 2, (size.height + scoreBarSize.height) / 2),
      app.sprites["assets/png/football_mode/football.png"],
    );
    addEntity(_ball);
  }

  /// Creates the two football teams.
  void _createFootballTeams() {
    _composition = FootballComposition(_field);

    _firstTeam = FootballTeam(
      app.firstPlayer,
      app.sprites["assets/png/pawns/red_pawn.png"],
      _composition.defaultComposition(FootballTeamSide.Left),
    );

    _firstTeam.turn = true;

    _secondTeam = FootballTeam(
      app.secondPlayer,
      app.sprites["assets/png/pawns/blue_pawn.png"],
      _composition.defaultComposition(FootballTeamSide.Right),
    );

    addEntity(_firstTeam);
    addEntity(_secondTeam);
  }

  /// Switchs team turns.
  void nextRound() {
    _firstTeam.turn = !_firstTeam.turn;
    _secondTeam.turn = !_secondTeam.turn;
    _scoreBar.reset();
  }

  FootballTeam get firstTeam => _firstTeam;

  FootballTeam get secondTeam => _secondTeam;

  Football get ball => _ball;

  FootballGoalSystem get goalSystem => _goalSystem;

  FootballField get field => _field;
}
