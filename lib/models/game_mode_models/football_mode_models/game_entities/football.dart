import 'package:gamez/gamez.dart';

class Football extends CircularSprite {
  Football(Vector position, Sprite sprite) : super(position, 15) {
    super.sprite = sprite;
  }

  @override
  void update(double dt) {
    var friction = 0.03;
    velocity += -velocity * friction;

    position += velocity * dt;
  }

  @override
  void reset() => velocity = Vector(0, 0);
}
