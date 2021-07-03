import 'package:flutter/scheduler.dart';

class GameTicker {
  late Ticker _ticker;
  Function _update;

  Duration _previous = Duration.zero;

  GameTicker(this._update) {
    _ticker = Ticker(_onTick);
  }

  void _onTick(Duration current) {
    Duration dt =
        _previous == Duration.zero ? Duration.zero : current - _previous;

    _previous = current;

    _update(dt.inMilliseconds / 1000);
  }

  void start() => _ticker.start();

  void stop() => _ticker.stop();

  void pause() {
    _previous = Duration.zero;
    _ticker.muted = true;
  }

  void restart() => _ticker.muted = false;
}
