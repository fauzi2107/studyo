import 'dart:math';

import 'package:flutter/material.dart';

import 'line_triangle.dart';

class InteractiveLineWithTriangle extends StatefulWidget {

  final Function(int) onChangeColumn;

  const InteractiveLineWithTriangle({super.key, required this.onChangeColumn});

  @override
  _InteractiveLineWithTriangleState createState() =>
      _InteractiveLineWithTriangleState();
}

class _InteractiveLineWithTriangleState extends State<InteractiveLineWithTriangle> {
  // Start and end points for the line
  Offset startPoint = Offset(0, 150);
  Offset? endPoint;

  // Initial position of the triangle (starting at the end point)
  Offset? trianglePosition;

  // Calculate the distance between two points
  double distance(Offset a, Offset b) {
    return sqrt(pow(b.dx - a.dx, 2) + pow(b.dy - a.dy, 2));
  }

  double get width => MediaQuery.of(context).size.width * 0.7;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        endPoint = Offset(width, 150);
        trianglePosition = Offset(width, 150);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(width, 150);
    trianglePosition ??= Offset(width, 150);

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
        size: Size(width, width * 0.6),
        painter: LineWithMovableTrianglePainter(
          startPoint: startPoint,
          endPoint: endPoint!,
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