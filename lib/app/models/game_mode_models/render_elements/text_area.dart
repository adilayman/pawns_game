import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:pawns_game/core/models/render_elements/render_element.dart';
import 'package:pawns_game/core/resources/vector.dart';

class TextArea extends RenderElement {
  String text;
  double fontSize;

  TextArea(Vector position, this.text, {this.fontSize = 58})
      : super(position, null);

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
}
