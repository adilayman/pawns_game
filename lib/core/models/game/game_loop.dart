import 'dart:async';

class GameLoop {
  Timer _timer;
  double fps;

  bool _running = false;
  Function _update;

  bool _waiting = false;
  double _waitTime = 0;
  double _currentWaitTime = 0;
  Function _afterWait;

  /// Creates a  new game loop.
  ///
  /// The [_update] function that will be called at each frame.
  GameLoop(this._update, {this.fps = 45}) {
    int ms = 1000 ~/ fps;

    _timer = Timer.periodic(
      Duration(milliseconds: ms),
      (_) {
        // update game state.
        if (_running && !_waiting) _update(ms / 1000);

        // perform waiting operation.
        if (_waiting) _performWaiting(ms / 1000);
      },
    );
  }

  /// Resets the game loop state after waiting.
  void _resetWaiting() {
    _waiting = false;
    _waitTime = 0;
    _currentWaitTime = 0;
    _afterWait = null;
    _running = true;
  }

  /// Performs waiting procedure.
  void _performWaiting(double seconds) {
    _currentWaitTime += seconds;
    if (_currentWaitTime >= _waitTime) {
      _currentWaitTime = 0;
      if (_afterWait != null) _afterWait();
      _resetWaiting();
    }
  }

  /// Starts the game loop.
  void start() => _running = true;

  /// Pauses the game loop.
  void pause() => _running = false;

  /// Cancels the game loop.
  void stop() => _timer.cancel();

  /// Pauses the game loop for a given [seconds]
  ///
  /// It is also possible to perform an [afterWait] function
  /// when the waiting ends
  void wait(double seconds, {Function afterWait}) {
    _waiting = true;
    _waitTime = seconds;
    _afterWait = afterWait;
  }
}
