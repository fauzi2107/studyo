import 'package:studyo/features/painter/triangle/enum_triangle_direction.dart';

import '../../../ui_export.dart';

class InteractiveTriangleUpward extends StatefulWidget {

  final Function(int) onChangeColumn;
  final Function(double) onMovePointer;
  final double? position;
  final TriangleDirection direction;

  const InteractiveTriangleUpward({super.key,
    required this.onChangeColumn,
    required this.onMovePointer,
    this.position,
    required this.direction
  });

  @override
  _InteractiveTriangleUpwardState createState() =>
      _InteractiveTriangleUpwardState();
}

class _InteractiveTriangleUpwardState extends InteractiveTriangleState<InteractiveTriangleUpward> {
  @override
  Widget build(BuildContext context) {
    endPoint ??= widget.direction.endPoint(width);
    trianglePosition ??= endPoint;
    if (widget.position != null) {
      trianglePosition = Offset(widget.position!, 0);
    }

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        trianglePosition = onPositionUpdate(details, widget.direction.startPoint);
        final totalColumn = (trianglePosition!.dx / width) * 10;
        widget.onChangeColumn(customMapping(totalColumn.toInt()));
        widget.onMovePointer(trianglePosition!.dx);
      },
      child: CustomPaint(
        size: Size(width, triangleSize),
        painter: TrianglePainter(
          direction: widget.direction,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}