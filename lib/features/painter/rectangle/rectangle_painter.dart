import 'package:flutter/material.dart';

class BaseRectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object to style the rectangles
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill; // You can also use .stroke for outline

    // Drawing multiple rectangles
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        double left = i * 50.0; // x coordinate
        double top = j * 50.0; // y coordinate
        double right = left + 40; // width of the rectangle
        double bottom = top + 40; // height of the rectangle

        // Draw rectangle at calculated position
        canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint for now
  }
}

class RectanglePainter extends CustomPainter {
  final List<List<Color>> rectangleColors;
  final double rectSize;
  final int columns, rows;

  RectanglePainter(this.rectangleColors, this.rectSize, this.columns, this.rows);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // set width and height based on total column and rows
    final widthHeight = columns == 1 && rows == 1
        ? size.height : size.height / rows;

    // Draw the rectangles
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        double left = i * rectSize; // x coordinate
        double top = j * rectSize; // y coordinate
        double right = left + (columns == 1 ? widthHeight : rectSize * 0.95); // width of the rectangle
        if (i == columns-1) right = left + rectSize; // override width of last column

        double bottom = top + widthHeight; // height of the rectangle
        print('$i $j $left $top $right $bottom');

        // Set the color for the current rectangle
        paint.color = rectangleColors[i][j];

        // Draw rectangle
        canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint when the state changes
  }
}