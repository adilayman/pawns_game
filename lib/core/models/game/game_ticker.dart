import 'package:flutter/scheduler.dart';

class GameTicker {
  Ticker _ticker;
  Function _update;

  Duration _previous = Duration.zero;

  GameTicker(this._update) {
    _ticker = Ticker(_onTick);
  }

  void _onTick(Duration current) {
    Duration dt = current - _previous;
    _previous = current;
    _update(dt.inMilliseconds / 1000);
  }

  void start() {
    if (!_ticker.isActive) _ticker.start();
  }

  void stop() => _ticker.stop();

  void pause() {
    _previous = Duration.zero;
    _ticker.muted = true;
  }

  void restart() {
    _previous = Duration.zero;
    _ticker.muted = false;
  }
}
