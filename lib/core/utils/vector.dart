import 'dart:math';

/// Point presentation
class Vector {
  double x, y;

  Vector(this.x, this.y);

  Vector normalize() {
    double unit = sqrt(x * x + y * y);
    return Vector(x / unit, y / unit);
  }

  double unit() {
    return sqrt(x * x + y * y);
  }
}
