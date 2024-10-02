import 'package:flutter/material.dart';

import 'rectangle_painter.dart';

class InteractiveRectangles extends StatefulWidget {
  const InteractiveRectangles({super.key,
    required this.totalColumn, required this.totalRow});

  final int totalColumn, totalRow;

  @override
  _InteractiveRectanglesState createState() => _InteractiveRectanglesState();
}

class _InteractiveRectanglesState extends State<InteractiveRectangles> {
  // 2D List to store the color state of each rectangle
  late List<List<Color>> rectangleColors;

  @override
  Widget build(BuildContext context) {
    rectangleColors = List.generate(widget.totalColumn, (index) =>
        List.generate(widget.totalRow, (j) => Colors.blue));
    final width = MediaQuery.of(context).size.width * 0.7;

    // Size of each rectangle
    var rectSize = width / rectangleColors.length;

    return GestureDetector(
      onTapDown: (details) { // will update immediately after touch
        // Calculate the x and y indices of the tapped rectangle
        final tapX = details.localPosition.dx;
        final tapY = details.localPosition.dy;

        // Determine which rectangle was tapped
        final int i = (tapX ~/ rectSize).clamp(0, 4);
        final int j = (tapY ~/ rectSize).clamp(0, 4);

        // Change color of the tapped rectangle
        setState(() {
          rectangleColors[i][j] = rectangleColors[i][j] == Colors.blue ? Colors.red : Colors.blue;
        });
      },
      child: CustomPaint(
        size: Size(width, width),
        painter: RectanglePainter(rectangleColors, rectSize,
            widget.totalColumn, widget.totalRow),
      ),
    );
  }
}