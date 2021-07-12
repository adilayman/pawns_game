import 'package:flutter/material.dart';
import 'package:info2051_2018/core/utils/vector.dart';

enum TeamSide { LeftSide, RightSide }

class SoccerComposition {
  Vector _coordinates;
  Size _size;

  List<Vector> _composition;

  SoccerComposition(this._coordinates, this._size);

  List<Vector> defaultComposition(TeamSide side) {
    _composition = [];

    _composition.add(Vector(_x(_size.width / 16, side), _y(_size.height / 2)));

    _composition
        .add(Vector(_x(3.5 * _size.width / 16, side), _y(_size.height / 4)));

    _composition.add(
        Vector(_x(3.5 * _size.width / 16, side), _y(3 * _size.height / 4)));

    _composition
        .add(Vector(_x(6 * _size.width / 16, side), _y(_size.height / 2)));

    return _composition;
  }

  double _x(double x, TeamSide side) {
    if (side == TeamSide.LeftSide) return _coordinates.x + x;
    return _coordinates.x + (x - _size.width).abs();
  }

  double _y(double y) => _coordinates.y + y;
}
