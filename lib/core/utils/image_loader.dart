import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

class ImageLoader {
  String _pathname;

  ui.Image _image;

  Function onLoad;

  ImageLoader(this._pathname, {this.onLoad});

  Future<Null> loadImage() async {
    _image = await _loadFutureImage(_pathname);

    if (onLoad != null) {
      Stream stream = Stream<ui.Image>.fromFuture(_loadFutureImage(_pathname));
      stream.listen((event) => onLoad());
    }
  }

  Future<ui.Image> _loadFutureImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  ui.Image get image => _image;

  bool get isLoaded => _image != null;
}
