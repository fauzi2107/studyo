import '../../../ui_export.dart';
import 'interactive_triangle_state.dart';
import 'triangle_painter.dart';

class InteractiveTriangleRightward extends StatefulWidget {

  final Function(int) onChangeRow;
  final Function(double) onMovePointer;
  final double? position;

  const InteractiveTriangleRightward({super.key,
    required this.onChangeRow,
    required this.onMovePointer,
    this.position
  });

  @override
  _InteractiveTriangleRightwardState createState() =>
      _InteractiveTriangleRightwardState();
}

class _InteractiveTriangleRightwardState extends InteractiveTriangleState<InteractiveTriangleRightward> {
  // Set the start and end points for a vertical line
  Offset startPoint = const Offset(25, 0);  // Top of the line

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(triangleSize, width);
    trianglePosition ??= endPoint; // initialize starting position
    if (widget.position != null) {
      trianglePosition = Offset(triangleSize, widget.position!);
    }

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        trianglePosition = onPositionUpdate(details, startPoint);
        final totalRow = (trianglePosition!.dy / width) * 10;
        widget.onChangeRow(customMapping(totalRow.toInt()));
        widget.onMovePointer(trianglePosition!.dy);
      },
      child: CustomPaint(
        size: Size(triangleSize, width),
        painter: TrianglePainter(
          angle: 0, // point triangle to the right
          triangleSize: triangleSize,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}