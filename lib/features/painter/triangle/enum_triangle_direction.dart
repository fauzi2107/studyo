import 'package:studyo/ui_export.dart';

enum TriangleDirection {downward, upward, leftward, rightward}

const triangleSize = 25.0;

extension TriangleDirectionExt on TriangleDirection {
  
  /// set angle triangle based on direction
  double get angle {
    switch (this) {
      case TriangleDirection.downward:
        return pi / 2;
      case TriangleDirection.upward:
        return -pi / 2;
      case TriangleDirection.leftward:
        return pi;
      case TriangleDirection.rightward:
        return 0;
    }
  }

  /// set starting point of direction
  Offset get startPoint {
    switch (this) {
      case TriangleDirection.downward:
        return const Offset(0, triangleSize);
      case TriangleDirection.upward:
      case TriangleDirection.leftward:
        return const Offset(0, 0);
      case TriangleDirection.rightward:
        return const Offset(triangleSize, 0);
    }
  }

  /// set default end point of direction
  Offset endPoint(double length) {
    switch (this) {
      case TriangleDirection.downward:
        return Offset(length, triangleSize);
      case TriangleDirection.upward:
        return Offset(length, 0);
      case TriangleDirection.leftward:
        return Offset(0, length);
      case TriangleDirection.rightward:
        return Offset(triangleSize, length);
    }
  }
}