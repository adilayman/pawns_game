import 'dart:math';
import 'dart:ui';

/// 2D Vector.
///
/// Note: All vector operations are not available.
class Vector {
  double x, y;

  Vector(this.x, this.y);

  /// Division operator.
  Vector operator /(double denum) => Vector(x / denum, y / denum);

  /// Substraction operator.
  Vector operator -(Vector other) => Vector(x - other.x, y - other.y);

  /// Multiplication operator.
  Vector operator *(double scale) => Vector(x * scale, y * scale);

  /// Returns the dot product of two vectors.
  double dot(Vector v2) => x * v2.x + y * v2.y;

  /// Returns the euclidean distance between two vectors.
  double distance(Vector v2) =>
      sqrt((x - v2.x) * (x - v2.x) + (y - v2.y) * (y - v2.y));

  /// Clones the vector.
  Vector get clone => Vector(x, y);

  /// Returns an Offset object.
  Offset get toOffset => Offset(x, y);

  /// Returns a Size object.
  Size get toSize => Size(x, y);
}
