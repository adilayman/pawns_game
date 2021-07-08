import 'dart:async';

class GameLoop {
  Timer timer;
  bool _running = false;

  double _fps;

  Function _update;

  GameLoop(this._update, {bool running = false, double fps = 60}) {
    _running = running;
    _fps = fps;

    double ms = 1000 / _fps;
    timer = Timer.periodic(
      Duration(milliseconds: ms.toInt()),
      (time) {
        if (_running) _update(ms / 1000);
      },
    );
  }

  void start() => _running = true;

  void pause() => _running = false;
}
