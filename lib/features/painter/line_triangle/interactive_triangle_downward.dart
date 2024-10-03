import 'package:studyo/features/painter/line_triangle/interactive_triangle_state.dart';

import '../../../ui_export.dart';
import 'triangle_painter.dart';

class InteractiveTriangleDownward extends StatefulWidget {

  final Function(int) onChangeColumn;

  const InteractiveTriangleDownward({super.key, required this.onChangeColumn});

  @override
  _InteractiveTriangleDownwardState createState() =>
      _InteractiveTriangleDownwardState();
}

class _InteractiveTriangleDownwardState extends InteractiveTriangleState<InteractiveTriangleDownward> {
  // Start and end points for the line
  Offset startPoint = const Offset(0, 25);

  @override
  Widget build(BuildContext context) {
    endPoint ??= Offset(width, triangleSize);
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
          angle: pi / 2, // point triangle to downward
          triangleSize: triangleSize,
          trianglePosition: trianglePosition!,
        ),
      ),
    );
  }
}