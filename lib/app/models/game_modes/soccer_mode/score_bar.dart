import 'package:flutter/material.dart';
import 'package:info2051_2018/core/utils/circular_progress_bar.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class ScoreBar {
  Vector _coordinates;
  Size _size;

  CircularProgressBar firstAvatar;
  CircularProgressBar _secondAvatar;

  ScoreBar(this._coordinates, this._size) {
    firstAvatar = CircularProgressBar(
        Vector(_size.width * 0.25, _size.height / 2), _size.height * 0.4, 15);

    _secondAvatar = CircularProgressBar(
        Vector(_size.width * 0.75, _size.height / 2), _size.height * 0.4, 15);
  }

  void _renderBar(Canvas canvas) {
    Paint paint = Paint();
    paint.color = Color.fromRGBO(225, 255, 225, 0.75);
    canvas.drawRect(_coordinates.toOffset & _size, paint);
  }

  void _renderAvatars(Canvas canvas) {
    firstAvatar.render(canvas);
    _secondAvatar.render(canvas);
  }

  void render(Canvas canvas) {
    _renderBar(canvas);
    _renderAvatars(canvas);
  }
}
