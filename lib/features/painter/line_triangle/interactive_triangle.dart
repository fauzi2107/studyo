import 'dart:math';

import 'package:flutter/material.dart';

import 'triangle_downward_painter.dart';

class InteractiveLineWithTriangle extends StatefulWidget {

  final Function(int) onChangeColumn;

  const InteractiveLineWithTriangle({super.key, required this.onChangeColumn});

  @override
  _InteractiveLineWithTriangleState createState() =>
      _InteractiveLineWithTriangleState();
}

class _InteractiveLineWithTriangleState extends State<InteractiveLineWithTriangle> {
  // Start and end points for the line
  Offset startPoint = const Offset(0, 25);
  Offset? endPoint;
  final triangleSize = 25.0;

  // Initial position of the triangle (starting at the end point)
  Offset? trianglePosition;

  // Calculate the distance between two points
  double distance(Offset a, Offset b) {
    return sqrt(pow(b.dx - a.dx, 2) + pow(b.dy - a.dy, 2));
  }

  double get width => MediaQuery.of(context).size.width * 0.7;

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(width, triangleSize);
    trianglePosition ??= Offset(width, triangleSize);

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
          final totalColumn = (trianglePosition!.dx / width) * 10;
          widget.onChangeColumn(customMapping(totalColumn.toInt()));
        });
      },
      child: CustomPaint(
        size: Size(width, triangleSize),
        painter: TriangleDownwardPainter(
          triangleSize: triangleSize,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }

  int customMapping(int number) {
    if (number >= 1 && number <= 10) {
      return 11 - number;  // Reverse the range 1-10
    }

    return 10;
  }
}