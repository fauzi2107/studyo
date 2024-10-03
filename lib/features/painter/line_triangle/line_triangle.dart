import 'dart:math';

import 'package:flutter/material.dart';

class LineWithMovableTrianglePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final Offset trianglePosition;

  LineWithMovableTrianglePainter({
    required this.startPoint,
    required this.endPoint,
    required this.trianglePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw the line
    canvas.drawLine(startPoint, endPoint, paint);

    // Draw the triangle (arrowhead) at the triangle position
    drawTriangle(canvas, paint, trianglePosition, startPoint, endPoint);
  }

  void drawTriangle(Canvas canvas, Paint paint, Offset tip, Offset start, Offset end) {
    const double triangleSize = 25.0;

    // Calculate the angle of the line (direction)
    double angle = pi / 2;

    // Define the points of the triangle (arrowhead)
    Offset point1 = Offset(
      tip.dx - triangleSize * cos(angle - pi / 6),
      tip.dy - triangleSize * sin(angle - pi / 6),
    );

    Offset point2 = Offset(
      tip.dx - triangleSize * cos(angle + pi / 6),
      tip.dy - triangleSize * sin(angle + pi / 6),
    );

    // Create a path for the triangle
    Path path = Path()
      ..moveTo(tip.dx, tip.dy) // Move to the tip (end of the line)
      ..lineTo(point1.dx, point1.dy) // Line to first triangle point
      ..lineTo(point2.dx, point2.dy) // Line to second triangle point
      ..close(); // Close the triangle path

    // Fill the triangle with color
    final trianglePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // canvas.rotate(90);
    canvas.drawPath(path, trianglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint when the triangle position changes
  }
}