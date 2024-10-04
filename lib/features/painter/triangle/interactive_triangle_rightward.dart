import 'package:studyo/features/painter/triangle/enum_triangle_direction.dart';

import '../../../ui_export.dart';
import 'interactive_triangle_state.dart';
import 'triangle_painter.dart';

class InteractiveTriangleRightward extends StatefulWidget {

  final Function(int) onChangeRow;
  final Function(double) onMovePointer;
  final double? position;
  final TriangleDirection direction;

  const InteractiveTriangleRightward({super.key,
    required this.onChangeRow,
    required this.onMovePointer,
    this.position,
    required this.direction
  });

  @override
  _InteractiveTriangleRightwardState createState() =>
      _InteractiveTriangleRightwardState();
}

class _InteractiveTriangleRightwardState extends InteractiveTriangleState<InteractiveTriangleRightward> {
  @override
  Widget build(BuildContext context) {
    endPoint ??= widget.direction.endPoint(width);
    trianglePosition ??= endPoint; // initialize starting position
    if (widget.position != null) {
      trianglePosition = Offset(triangleSize, widget.position!);
    }

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        trianglePosition = onPositionUpdate(details, widget.direction.startPoint);
        final totalRow = (trianglePosition!.dy / width) * 10;
        widget.onChangeRow(customMapping(totalRow.toInt()));
        widget.onMovePointer(trianglePosition!.dy);
      },
      child: CustomPaint(
        size: Size(triangleSize, width),
        painter: TrianglePainter(
          direction: widget.direction,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}