import '../../../ui_export.dart';
import 'interactive_triangle_state.dart';
import 'triangle_painter.dart';

class InteractiveTriangleLeftward extends StatefulWidget {

  final Function(int) onChangeRow;

  const InteractiveTriangleLeftward({super.key, required this.onChangeRow});

  @override
  _InteractiveTriangleLeftwardState createState() =>
      _InteractiveTriangleLeftwardState();
}

class _InteractiveTriangleLeftwardState extends InteractiveTriangleState<InteractiveTriangleLeftward> {
  // Set the start and end points for a vertical line
  Offset startPoint = const Offset(0, 0);  // Top of the line

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(0, width);
    trianglePosition ??= endPoint; // initialize starting position

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        setState(() {
          trianglePosition = onPositionUpdate(details, startPoint);
          final totalRow = (trianglePosition!.dy / width) * 10;
          widget.onChangeRow(customMapping(totalRow.toInt()));
        });
      },
      child: CustomPaint(
        size: Size(triangleSize, width),
        painter: TrianglePainter(
          angle: pi, // point triangle to the right
          triangleSize: triangleSize,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}