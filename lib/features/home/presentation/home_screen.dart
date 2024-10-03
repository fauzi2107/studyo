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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InteractiveTriangleRightward(
                  position: verticalPosition,
                  onMovePointer: onUpdateVerticalPointer,
                  onChangeRow: onUpdateRows,
                ),
                InteractiveRectangles(
                  totalColumn: columns,
                  totalRow: rows,
                ),
                InteractiveTriangleLeftward(
                  position: verticalPosition,
                  onMovePointer: onUpdateVerticalPointer,
                  onChangeRow: onUpdateRows,
                ),
              ],
            ),
            InteractiveTriangleUpward(
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