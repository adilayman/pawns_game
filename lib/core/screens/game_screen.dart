import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:info2051_2018/core/models/game/game.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
abstract class GameView extends StatelessWidget {
  Game game;

  GameView({@required this.game, @required Color backgroundColor});

  @override
  Widget build(BuildContext context) {
    game.init(MediaQuery.of(context).size); // init fields given screen size

    return ChangeNotifierProvider(
      create: (context) => game,
      child: Consumer<Game>(
        builder: (context, game, _) {
          return GestureDetector(
            onLongPressMoveUpdate: (details) =>
                game.onLongPressMoveUpdate(details.globalPosition),
            onLongPressStart: (details) =>
                game.onLongPressStart(details.globalPosition),
            onLongPressEnd: (details) =>
                game.onLongPressEnd(details.globalPosition),
            child: CustomPaint(
              painter: _GamePainter(game.render),
            ),
          );
        },
      ),
    );
  }
}

class _GamePainter extends CustomPainter {
  Function _render;

  _GamePainter(this._render);

  @override
  void paint(Canvas canvas, Size size) {
    if (_render != null) _render(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
