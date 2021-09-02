import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/game.dart';

// ignore: must_be_immutable
abstract class GameScreen extends StatelessWidget {
  Game game;
  List<Widget> _children = [];

  GameScreen({@required this.game});

  /// Adds a new child to the game tree.
  void addChild(Widget child) => _children.add(child);

  @override
  Widget build(BuildContext context) {
    game.init(context);
    return ChangeNotifierProvider(
      create: (context) => game,
      child: Consumer<Game>(
        builder: (context, game, _) {
          return Scaffold(
            body: GestureDetector(
              onLongPressMoveUpdate: (details) =>
                  game.onLongPressMoveUpdate(details.globalPosition),
              onLongPressStart: (details) =>
                  game.onLongPressStart(details.globalPosition),
              onLongPressEnd: (details) =>
                  game.onLongPressEnd(details.globalPosition),
              child: Stack(
                children: [
                  CustomPaint(
                    size: game.size,
                    painter: _GamePainter(game.render),
                  ),
                  ..._children,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GamePainter extends CustomPainter {
  Function(Canvas canvas, Size size) _render;

  _GamePainter(this._render);

  @override
  void paint(Canvas canvas, Size size) {
    if (_render != null) _render(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
