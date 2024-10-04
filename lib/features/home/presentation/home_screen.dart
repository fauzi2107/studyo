import 'package:studyo/features/painter/triangle/enum_triangle_direction.dart';

import '../../../ui_export.dart';

part 'home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeState<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends HomeState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InteractiveTriangleDownward(
              position: horizontalPosition,
              onMovePointer: onUpdateHorizontalPointer,
              onChangeColumn: onUpdateColumn,
              direction: TriangleDirection.downward,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InteractiveTriangleRightward(
                  position: verticalPosition,
                  onMovePointer: onUpdateVerticalPointer,
                  onChangeRow: onUpdateRows,
                  direction: TriangleDirection.rightward,
                ),
                InteractiveRectangles(
                  totalColumn: columns,
                  totalRow: rows,
                ),
                InteractiveTriangleLeftward(
                  position: verticalPosition,
                  onMovePointer: onUpdateVerticalPointer,
                  onChangeRow: onUpdateRows,
                  direction: TriangleDirection.leftward,
                ),
              ],
            ),
            InteractiveTriangleUpward(
              direction: TriangleDirection.upward,
              position: horizontalPosition,
              onMovePointer: onUpdateHorizontalPointer,
              onChangeColumn: onUpdateColumn,
            )
          ],
        ),
      ),
    );
  }
}