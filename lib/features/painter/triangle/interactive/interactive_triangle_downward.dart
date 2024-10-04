import '../../../../ui_export.dart';

class InteractiveTriangleDownward extends StatefulWidget {

  final Function(int) onChangeColumn;
  final Function(double) onMovePointer;
  final double? position;
  final TriangleDirection direction;
  final int columns;

  const InteractiveTriangleDownward({super.key,
    required this.onChangeColumn,
    this.position,
    required this.onMovePointer,
    required this.direction,
    required this.columns
  });

  @override
  _InteractiveTriangleDownwardState createState() =>
      _InteractiveTriangleDownwardState();
}

class _InteractiveTriangleDownwardState extends InteractiveTriangleState<InteractiveTriangleDownward> {
  @override
  Widget build(BuildContext context) {
    endPoint ??= widget.direction.endPoint(width);
    trianglePosition ??= endPoint;
    if (widget.position != null) {
      trianglePosition = Offset(widget.position!, triangleSize);
    }

    return GestureDetector(
      // Detect drag updates and move the triangle along the line
      onPanUpdate: (details) {
        trianglePosition = onPositionUpdate(details, widget.direction.startPoint);
        final totalColumn = customMapping(((trianglePosition!.dx / width) * 10).toInt());
        widget.onChangeColumn(totalColumn);
        widget.onMovePointer(trianglePosition!.dx);
      },
      child: CustomPaint(
        size: Size(width, triangleSize),
        painter: TrianglePainter(
          text: '${widget.columns}',
          direction: widget.direction,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}