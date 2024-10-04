import '../../../ui_export.dart';

part 'home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeState<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends HomeState<HomeScreen> {
  int numerator = 1, denominator = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  numerator = Random().nextInt(100) + 1;
                  denominator = Random().nextInt(100) + 1;
                });
              },
              icon: const Icon(Icons.refresh_rounded),
              color: Colors.grey,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20
          ),
          child: Column(
            children: [
              Text('$numerator'),
              SizedBox(
                width: 25,
                child: Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              Text('$denominator'),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InteractiveTriangleDownward(
                      position: horizontalPosition,
                      onMovePointer: onUpdateHorizontalPointer,
                      onChangeColumn: onUpdateColumn,
                      direction: TriangleDirection.downward,
                      columns: columns,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InteractiveTriangleRightward(
                          rows: rows,
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
                          rows: rows,
                          position: verticalPosition,
                          onMovePointer: onUpdateVerticalPointer,
                          onChangeRow: onUpdateRows,
                          direction: TriangleDirection.leftward,
                        ),
                      ],
                    ),
                    InteractiveTriangleUpward(
                      columns: columns,
                      direction: TriangleDirection.upward,
                      position: horizontalPosition,
                      onMovePointer: onUpdateHorizontalPointer,
                      onChangeColumn: onUpdateColumn,
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {

                },
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                elevation: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Icon(Icons.check,
                    color: Colors.white,
                    size: 32,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}