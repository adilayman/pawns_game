import 'package:flutter/material.dart';

import 'package:gamez/gamez.dart';

class TextArea extends GameEntity {
  String text;
  double fontSize;

  TextArea(Vector position, this.text, {this.fontSize = 58})
      : super(position, Size.zero);

  @override
  void render(Canvas canvas) {
    TextSpan span = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: this.fontSize,
        fontFamily: 'GearUp',
      ),
      text: text,
    );
    TextPainter textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(x - textPainter.size.width / 2, y - textPainter.size.height / 2),
    );
  }

  @override
  bool contains(Offset position) => false;

  @override
  void reset() {}

  @override
  void update(double dt) {}

  @override
  void handleGesture(Offset position, Gesture gesture) {}
}
