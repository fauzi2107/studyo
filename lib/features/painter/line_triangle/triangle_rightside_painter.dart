import 'dart:math';

import 'package:flutter/material.dart';

class TriangleRightSidePainter extends CustomPainter {
  final Offset trianglePosition;
  final double triangleSize;

  TriangleRightSidePainter({
    required this.trianglePosition,
    required this.triangleSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Angle zero to make triangle point to the right side
    double angle = 0;

    // Define the points of the triangle (arrowhead)
    Offset point1 = Offset(
      trianglePosition.dx - triangleSize * cos(angle - pi / 6),
      trianglePosition.dy - triangleSize * sin(angle - pi / 6),
    );

    Offset point2 = Offset(
      trianglePosition.dx - triangleSize * cos(angle + pi / 6),
      trianglePosition.dy - triangleSize * sin(angle + pi / 6),
    );

    // Create a path for the triangle
    Path path = Path()
      ..moveTo(trianglePosition.dx, trianglePosition.dy) // Move to the tip (end of the line)
      ..lineTo(point1.dx, point1.dy) // Line to first triangle point
      ..lineTo(point2.dx, point2.dy) // Line to second triangle point
      ..close(); // Close the triangle path

    // Fill the triangle with color
    final trianglePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, trianglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint when the triangle position changes
  }
}