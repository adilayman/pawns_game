import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:info2051_2018/app/models/game_modes/soccer_mode/soccer_entities/pawn.dart';
import 'package:info2051_2018/core/models/game_entity/game_entity.dart';
import 'package:info2051_2018/core/utils/image_loader.dart';
import 'package:info2051_2018/core/utils/vector.dart';

class SoccerTeam extends GameEntity {
  List<Pawn> pawns = [];

  ImageLoader _imageLoader;

  SoccerTeam(String image, List<Vector> positions) : super(Vector(0, 0)) {
    _imageLoader = ImageLoader(image, onLoad: onImageLoad);
    _imageLoader.loadImage();

    for (Vector position in positions) {
      pawns.add(Pawn(Vector(position.x, position.y)));
    }

    //pawns.add(Pawn(Vector(200, 300), Colors.red.shade900, game));
  }

  ui.Image get image => _imageLoader.image;

  void onImageLoad() {
    pawns.forEach((pawn) => pawn.loadImage(_imageLoader.image));
    print("loaded");
  }

  @override
  bool contains(Offset position) => false;

  @override
  void onLongPressEnd(Offset position) {
    pawns.forEach((pawn) => pawn.onLongPressEnd(position));
  }

  @override
  void onLongPressMoveUpdate(Offset position) {
    pawns.forEach((pawn) => pawn.onLongPressMoveUpdate(position));
  }

  @override
  void onLongPressStart(Offset position) {
    pawns.forEach((pawn) => pawn.onLongPressStart(position));
  }

  @override
  void render(Canvas canvas) {
    pawns.forEach((pawn) => pawn.render(canvas));
  }

  @override
  bool update(double dt) {
    int nUpdates = 0;
    pawns.forEach((pawn) {
      if (pawn.update(dt)) nUpdates++;
    });
    return nUpdates > 0;
  }
}
