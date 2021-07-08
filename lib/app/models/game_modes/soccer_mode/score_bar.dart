import 'package:flutter/material.dart';
import 'package:info2051_2018/core/utils/circular_progress_bar.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class ScoreBar {
  Vector _coordinates;
  Size _size;

  CircularProgressBar _firstAvatar;
  CircularProgressBar _secondAvatar;

  ScoreBar(this._coordinates, this._size) {
    _firstAvatar = CircularProgressBar(
        Vector(_size.width * 0.25, _size.height / 2), _size.height * 0.4, 15);

    _secondAvatar = CircularProgressBar(
        Vector(_size.width * 0.75, _size.height / 2), _size.height * 0.4, 15);
  }

  void _renderBar(Canvas canvas) {
    Paint paint = Paint();

    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color.fromRGBO(255, 255, 255, 0.75),
        Color.fromRGBO(255, 255, 255, 0.75),
      ],
    ).createShader(_coordinates.toOffset() & _size);

    canvas.drawRect(_coordinates.toOffset() & _size, paint);
  }

  void _renderAvatars(Canvas canvas) {
    _firstAvatar.render(canvas);
    _secondAvatar.render(canvas);
  }

  void render(Canvas canvas) {
    _renderBar(canvas);
    _renderAvatars(canvas);

    // final rect = Rect.fromLTWH(
    //     _size.width * 0.25 - (_size.height - _size.height * 0.2) / 2,
    //     _size.height / 2 - (_size.height - _size.height * 0.2) / 2,
    //     (_size.height - _size.height * 0.2),
    //     (_size.height - _size.height * 0.2));
    // final startAngle = -pi / 2;
    // final sweepAngle = pi;
    // final useCenter = false;
    // final paint = Paint()
    //   ..color = Colors.black
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 4;
    // canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }
}
