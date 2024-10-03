import '../../../ui_export.dart';
import 'interactive_triangle_state.dart';
import 'triangle_painter.dart';

class InteractiveTriangleUpward extends StatefulWidget {

  final Function(int) onChangeColumn;

  const InteractiveTriangleUpward({super.key, required this.onChangeColumn});

  @override
  _InteractiveTriangleUpwardState createState() =>
      _InteractiveTriangleUpwardState();
}

class _InteractiveTriangleUpwardState extends InteractiveTriangleState<InteractiveTriangleUpward> {
  // Start and end points for the line
  Offset startPoint = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(width, 0);
    trianglePosition ??= endPoint;

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        setState(() {
          trianglePosition = onPositionUpdate(details, startPoint);
          final totalColumn = (trianglePosition!.dx / width) * 10;
          widget.onChangeColumn(customMapping(totalColumn.toInt()));
        });
      },
      child: CustomPaint(
        size: Size(width, triangleSize),
        painter: TrianglePainter(
          angle: -pi / 2, // point triangle to downward
          triangleSize: triangleSize,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}