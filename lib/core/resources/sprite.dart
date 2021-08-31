import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Sprite presentation.
class Sprite {
  String _pathname;
  ui.Image _image;

  Sprite(this._pathname);

  /// Loads the image of the sprite.
  Future<void> load() async => _image = await _loadFutureImage();

  /// Renders the image in the given [Canvas].
  void render(Canvas canvas, Offset lt, Size size) {
    if (image == null) return;
    canvas.drawImageRect(
      _image,
      Rect.fromLTWH(0, 0, _image.width.toDouble(), _image.height.toDouble()),
      Rect.fromLTWH(lt.dx, lt.dy, size.width, size.height),
      Paint(),
    );
  }

  /// Loads an image given its pathname.
  Future<ui.Image> _loadFutureImage() async {
    final ByteData data = await rootBundle.load(_pathname);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  String get pathname => _pathname;

  ui.Image get image => _image;
}
