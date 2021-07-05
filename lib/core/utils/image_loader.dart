import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

class ImageLoader {
  String _pathname;
  Size _size;
  bool _isLoaded = false;

  late ui.Image _image;

  ImageLoader(this._pathname, this._size);

  Future<Null> loadImage() async {
    _image = await _loadFutureImage(_pathname);
  }

  Future<ui.Image> _loadFutureImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      _isLoaded = true;
      print("true");
      return completer.complete(img);
    });
    return completer.future;
  }

  ui.Image get image => _image;

  bool get isLoaded => _isLoaded;
}
