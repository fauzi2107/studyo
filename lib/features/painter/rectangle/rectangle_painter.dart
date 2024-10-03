import 'package:flutter/material.dart';

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
        if (rows > 1) top = j * widthHeight; // override top of each row

        double right = left + (columns == 1 ? widthHeight : rectSize * 0.95); // width of the rectangle
        if (i == columns-1) right = left + rectSize; // override width of last column

        double bottom = top + (widthHeight * 0.95); // height of the rectangle
        if (j == rows-1) bottom = top + widthHeight; // override height of last row

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