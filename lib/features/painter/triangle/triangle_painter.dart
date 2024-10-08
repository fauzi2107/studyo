import '../../../ui_export.dart';

class TrianglePainter extends CustomPainter {
  final Offset trianglePosition;
  final String text;
  final TriangleDirection direction;

  TrianglePainter({
    this.text = '1',
    required this.trianglePosition,
    required this.direction
  });

  @override
  void paint(Canvas canvas, Size size) {
    // draw the triangle
    drawTriangle(canvas);

    // draw text inside triangle position
    drawTextInsideTriangle(canvas);
  }

  void drawTriangle(Canvas canvas) {
    // Define the points of the triangle (arrowhead)
    Offset point1 = Offset(
      trianglePosition.dx - triangleSize * cos(direction.angle - pi / 6),
      trianglePosition.dy - triangleSize * sin(direction.angle - pi / 6),
    );

    Offset point2 = Offset(
      trianglePosition.dx - triangleSize * cos(direction.angle + pi / 6),
      trianglePosition.dy - triangleSize * sin(direction.angle + pi / 6),
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

  void drawTextInsideTriangle(Canvas canvas) {
    // Define text style
    final span = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 9, // Adjust text size to fit inside the triangle
      ),
      text: text,
    );

    TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();

    // Paint the text at the center of the triangle
    textPainter.paint(canvas, textPosition(textPainter));
  }

  /// Calculate the center of the triangle to position the text
  Offset textPosition(TextPainter textPainter) {
    switch (direction) {
      case TriangleDirection.upward:
        return Offset(
          trianglePosition.dx - textPainter.width / 2,
          trianglePosition.dy + triangleSize / 2 - textPainter.height / 2,
        );
      case TriangleDirection.downward:
        return Offset(
          trianglePosition.dx - textPainter.width / 2,
          trianglePosition.dy - triangleSize / 2 - textPainter.height / 2,
        );
      case TriangleDirection.leftward:
        return Offset(
          trianglePosition.dx + triangleSize / 2 - textPainter.width / 2,
          trianglePosition.dy - textPainter.height / 2,
        );
      case TriangleDirection.rightward:
        return Offset(
          trianglePosition.dx - triangleSize / 2 - textPainter.width / 2,
          trianglePosition.dy - textPainter.height / 2,
        );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint when the triangle position changes
  }
}