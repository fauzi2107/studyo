import 'package:studyo/ui_export.dart';

abstract class InteractiveTriangleState<T extends StatefulWidget> extends State<T> {
  // Initial position of the triangle (starting at the end point)
  Offset? endPoint, trianglePosition;

  // get width of screen for how long triangle can moved
  // it is used for height too
  double get width => MediaQuery.of(context).size.width * 0.7;

  // Calculate the distance between two points
  double distance(Offset a, Offset b) {
    return sqrt(pow(b.dx - a.dx, 2) + pow(b.dy - a.dy, 2));
  }

  // Calculate position of triangle
  Offset onPositionUpdate(DragUpdateDetails details, Offset startPoint) {
    Offset localPosition = details.localPosition;

    // Calculate the projection of the drag point onto the line
    double lineLength = distance(startPoint, endPoint!);
    double projection = ((localPosition.dx - startPoint.dx) * (endPoint!.dx - startPoint.dx) +
        (localPosition.dy - startPoint.dy) * (endPoint!.dy - startPoint.dy)) /
        pow(lineLength, 2);

    // Constrain the projection between 0 and 1 to keep it on the line
    projection = projection.clamp(0.0, 1.0);

    // Calculate the new triangle position based on the projection
    return Offset(
      startPoint.dx + projection * (endPoint!.dx - startPoint.dx),
      startPoint.dy + projection * (endPoint!.dy - startPoint.dy),
    );
  }

  int customMapping(int number) {
    if (number >= 1 && number <= 10) {
      return 11 - number;  // Reverse the range 1-10
    }

    return 10;
  }
}