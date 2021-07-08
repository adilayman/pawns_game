import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class SoccerField {
  Vector _coordinates;
  Size _size;

  SoccerField(this._coordinates, this._size);

  Vector get topLeft => _coordinates;

  Vector get topRight => Vector(_coordinates.x + _size.width, _coordinates.y);

  Vector get bottomLeft =>
      Vector(_coordinates.x, _coordinates.y + _size.height);

  Vector get bottomRight =>
      Vector(_coordinates.x + _size.width, _coordinates.y + _size.height);

  void _drawBorders(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    Rect borders = Rect.fromLTWH(
        _coordinates.x, _coordinates.y, _size.width, _size.height);

    RRect rrectBorders = RRect.fromRectAndRadius(borders, Radius.circular(0));

    canvas.drawRRect(rrectBorders, paint);
  }

  void _drawField(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(0, 0, 0, 0.25);

    canvas.drawRect(_coordinates.toOffset() & _size, paint);
  }

  void render(Canvas canvas) {
    _drawField(canvas);
    _drawBorders(canvas);
  }
}
