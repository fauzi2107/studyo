import 'dart:math';

import 'package:flutter/material.dart';

class InteractiveVerticalLineWithTriangle extends StatefulWidget {
  @override
  _InteractiveVerticalLineWithTriangleState createState() =>
      _InteractiveVerticalLineWithTriangleState();
}

class _InteractiveVerticalLineWithTriangleState extends State<InteractiveVerticalLineWithTriangle> {
  // Set the start and end points for a vertical line
  Offset startPoint = const Offset(25, 0);  // Top of the line
  Offset? endPoint;   // Bottom of the line
  final triangleSize = 25.0;

  // Initial position of the triangle (starting at the end point)
  Offset? trianglePosition;

  // Calculate the distance between two points
  double distance(Offset a, Offset b) {
    return sqrt(pow(b.dx - a.dx, 2) + pow(b.dy - a.dy, 2));
  }

  double get height => MediaQuery.of(context).size.width * 0.7;

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(triangleSize, height);
    trianglePosition ??= endPoint; // initialize starting position

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        Offset localPosition = details.localPosition;

        // Calculate the projection of the drag point onto the line
        double lineLength = distance(startPoint, endPoint!);
        double projection = ((localPosition.dx - startPoint.dx) * (endPoint!.dx - startPoint.dx) +
            (localPosition.dy - startPoint.dy) * (endPoint!.dy - startPoint.dy)) /
            pow(lineLength, 2);

        // Constrain the projection between 0 and 1 to keep it on the line
        projection = projection.clamp(0.0, 1.0);

        // Calculate the new triangle position based on the projection
        Offset newTrianglePosition = Offset(
          startPoint.dx + projection * (endPoint!.dx - startPoint.dx),
          startPoint.dy + projection * (endPoint!.dy - startPoint.dy),
        );

        setState(() {
          trianglePosition = newTrianglePosition;
        });
      },
      child: CustomPaint(
        size: Size(triangleSize, height),
        painter: LineWithMovableTrianglePainter(
          triangleSize: triangleSize,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}

class LineWithMovableTrianglePainter extends CustomPainter {
  final Offset trianglePosition;
  final double triangleSize;

  LineWithMovableTrianglePainter({
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