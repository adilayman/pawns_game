import 'package:flutter/material.dart';
import 'package:gamez/gamez.dart';
import 'package:pawns_game/models/football_mode_models/football_team.dart';
import 'package:pawns_game/providers/game_mode_providers/football_mode_provider.dart';

/// Football goal score system
class FootballGoalSystem implements GameSystem {
  FootballModeProvider _game;

  bool _goal = false;
  int _maxScore = 2;

  FootballGoalSystem(this._game);

  @override
  void perform() {
    _checkGoal();
    _checkMaxScore();
  }

  /// Check max score for both teams.
  void _checkMaxScore() {
    _checkTeamMaxScore(_game.firstTeam);
    _checkTeamMaxScore(_game.secondTeam);
  }

  /// The the max score given [team].
  void _checkTeamMaxScore(FootballTeam team) {
    if (team.score < _maxScore) return;

    // increase wins and update the save file.
    team.player!.wins++;
    _game.app.updateSaveFile();

    // the game is over and the winner is defined.
    _game.gameOver = true;
    team.winner = true;

    // wait 3 seconds then stop the game loop and redirect to the home screen.
    _game.gameLoop.wait(3, afterWait: () {
      _game.gameLoop.stop();
      Navigator.pushNamed(_game.context, "/home");
    });
  }

  /// Checks goal for both teams.
  void _checkGoal() {
    if (_checkTeamGoal(_game.firstTeam, _isRightGoal()))
      _game.secondTeam.turn = true;
    else if (_checkTeamGoal(_game.secondTeam, _isLeftGoal()))
      _game.firstTeam.turn = true;

    if (_goal) _game.gameLoop.wait(3, afterWait: () => _goal = false);
  }

  /// Checks a [isGoal] given a [team].
  bool _checkTeamGoal(FootballTeam team, bool isGoal) {
    if (!isGoal) return false;
    team.score += 1;
    _game.reset();
    _goal = true;
    return true;
  }

  /// Checks the left goal.
  bool _isLeftGoal() {
    return _game.ball.y - _game.ball.radius >= _game.field.goalSize.height &&
        _game.ball.y + _game.ball.radius <= 2 * _game.field.goalSize.height &&
        _game.ball.x <= _game.field.left;
  }

  /// Checks the right goal.
  bool _isRightGoal() {
    return _game.ball.y - _game.ball.radius >= _game.field.goalSize.height &&
        _game.ball.y + _game.ball.radius <= 2 * _game.field.goalSize.height &&
        _game.ball.x >= _game.field.right;
  }

  bool get goal => _goal;
}
