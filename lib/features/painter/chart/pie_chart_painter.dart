import '../../../ui_export.dart';

class PieChartPainter extends CustomPainter {
  // Data for the pie chart
  final List<double> values;
  // Colors for each slice
  final List<Color> colors;
  // Space between each slice
  final double spacing;
  // Width of the donut (center space) will calculate in percentage
  final double donutWidth;

  PieChartPainter({
    required this.values,
    required this.colors,
    this.spacing = 2.0,
    this.donutWidth = 20,
  }) : assert(donutWidth > 0 && donutWidth <= 50, 'Insert between 0 - 100, it will calculate as percentage');

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius - (size.height * (donutWidth / 100));
    final double total = values.reduce((a, b) => a + b);
    final offsetDistance = outerRadius * 0.07;
    const offsetAngleRadians = 2 * (pi / 67.5);
    final borderRadius = size.width * 0.05;

    double startAngle = -pi / 2;  // Start from the top (12 o'clock)

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / total) * (2 * pi) - spacing * (pi / 180);
      final Paint paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke;

      // Define the path for the slice with rounded edges
      Path path = Path();

      // Calculate primary points
      Offset outerStart = Offset(
        center.dx + outerRadius * cos(startAngle),
        center.dy + outerRadius * sin(startAngle),
      );
      Offset outerEnd = Offset(
        center.dx + outerRadius * cos(startAngle + sweepAngle),
        center.dy + outerRadius * sin(startAngle + sweepAngle),
      );

      Offset innerStart = Offset(
        center.dx + innerRadius * cos(startAngle),
        center.dy + innerRadius * sin(startAngle),
      );
      Offset innerEnd = Offset(
        center.dx + innerRadius * cos(startAngle + sweepAngle),
        center.dy + innerRadius * sin(startAngle + sweepAngle),
      );

      Offset outerStartOffset = Offset(
        center.dx + (outerRadius - offsetDistance) * cos(startAngle - offsetAngleRadians),  // Move inward by reducing radius
        center.dy + (outerRadius - offsetDistance) * sin(startAngle - offsetAngleRadians),
      );
      Offset outerEndOffset = Offset(
        center.dx + (outerRadius - offsetDistance) * cos(startAngle + sweepAngle + offsetAngleRadians),  // Move inward by reducing radius
        center.dy + (outerRadius - offsetDistance) * sin(startAngle + sweepAngle + offsetAngleRadians),
      );

      Offset innerStartOffset = Offset(
        innerStart.dx + offsetDistance * cos(startAngle - pi / 4),
        innerStart.dy + offsetDistance * sin(startAngle - pi / 4),
      );
      Offset innerEndOffset = Offset(
        innerEnd.dx + offsetDistance * cos(startAngle + sweepAngle + pi / 4),
        innerEnd.dy + offsetDistance * sin(startAngle + sweepAngle + pi / 4),
      );

      // Move to the outer start point, make a line of second outer start and make a round corner
      path.moveTo(outerStartOffset.dx, outerStartOffset.dy);
      path.arcToPoint(outerStart, radius: Radius.circular(borderRadius), clockwise: true);
      path.lineTo(outerStart.dx, outerStart.dy);

      // Draw the outer arc
      path.arcTo(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
        false,
      );

      // create and connect outer end point
      path.lineTo(outerEnd.dx, outerEnd.dy);
      path.arcToPoint(outerEndOffset, radius: Radius.circular(borderRadius), clockwise: true);
      path.lineTo(outerEndOffset.dx, outerEndOffset.dy);

      // Connect to the inner end point
      path.lineTo(innerEndOffset.dx, innerEndOffset.dy);
      path.arcToPoint(innerEnd, radius: Radius.circular(borderRadius), clockwise: true);
      path.lineTo(innerEnd.dx, innerEnd.dy);

      // Draw the inner arc back to the start
      path.arcTo(
        Rect.fromCircle(center: center, radius: innerRadius),
        startAngle + sweepAngle,
        -sweepAngle,
        false,
      );

      // create and connect inner start point
      path.lineTo(innerStart.dx, innerStart.dy);
      path.arcToPoint(innerStartOffset, radius: Radius.circular(borderRadius), clockwise: true);
      path.lineTo(innerStartOffset.dx, innerStartOffset.dy);

      // Close the path
      path.close();

      // Draw the path on the canvas
      canvas.drawPath(path, paint);

      // Move to the next slice
      startAngle += sweepAngle + (spacing * (pi / 180));  // Account for the space between slices
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;  // Redraw whenever values or colors change
  }
}