import 'package:gamez/gamez.dart';
import 'package:pawns_game/models/football_mode_models/football_field.dart';

/// Football team side.
enum FootballTeamSide { Left, Right }

class FootballComposition {
  FootballField _field;
  late List<Vector> _composition;

  FootballComposition(this._field);

  /// Creates a default composition given the team side.
  List<Vector> defaultComposition(FootballTeamSide side) {
    _composition = [];

    _composition.add(
        Vector(_x(_field.size.width / 16, side), _y(_field.size.height / 2)));

    _composition.add(Vector(_x(3.5 * _field.size.width / 16, side),
        _y(2.5 * _field.size.height / 4)));

    _composition.add(Vector(_x(3.5 * _field.size.width / 16, side),
        _y(1.5 * _field.size.height / 4)));

    _composition.add(Vector(
        _x(6 * _field.size.width / 16, side), _y(_field.size.height / 4)));

    _composition.add(Vector(
        _x(6 * _field.size.width / 16, side), _y(3 * _field.size.height / 4)));

    return _composition;
  }

  double _x(double x, FootballTeamSide side) {
    if (side == FootballTeamSide.Left) return _field.position.x + x;
    return _field.position.x + (x - _field.size.width).abs();
  }

  double _y(double y) => _field.position.y + y;
}
