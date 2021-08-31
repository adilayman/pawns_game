import 'dart:ui';

/// Game gesture interface.
abstract class GameGesture {
  /// OnLongPressMoveUpdate gesture.
  void onLongPressMoveUpdate(Offset position);

  /// onLongPressStart gesture.
  void onLongPressStart(Offset position);

  /// onLongPressEnd gesture.
  void onLongPressEnd(Offset position);
}
