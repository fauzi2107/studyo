import '../../../ui_export.dart';
import 'interactive_triangle_state.dart';
import 'triangle_painter.dart';

class InteractiveTriangleDownward extends StatefulWidget {

  final Function(int) onChangeColumn;
  final Function(double) onMovePointer;
  final double? position;

  const InteractiveTriangleDownward({super.key,
    required this.onChangeColumn,
    this.position,
    required this.onMovePointer
  });

  @override
  _InteractiveTriangleDownwardState createState() =>
      _InteractiveTriangleDownwardState();
}

class _InteractiveTriangleDownwardState extends InteractiveTriangleState<InteractiveTriangleDownward> {
  // Start and end points for the line
  Offset startPoint = const Offset(0, 25);
  int totalColumn = 1;

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(width, triangleSize);
    trianglePosition ??= endPoint;
    if (widget.position != null) {
      trianglePosition = Offset(widget.position!, triangleSize);
    }

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        trianglePosition = onPositionUpdate(details, startPoint);
        totalColumn = customMapping(((trianglePosition!.dx / width) * 10).toInt());
        widget.onChangeColumn(totalColumn);
        widget.onMovePointer(trianglePosition!.dx);
      },
      child: CustomPaint(
        size: Size(width, triangleSize),
        painter: TrianglePainter(
          text: '$totalColumn',
          angle: pi / 2, // point triangle to downward
          triangleSize: triangleSize,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}