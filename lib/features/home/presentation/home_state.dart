part of 'home_screen.dart';

abstract class HomeState<T extends HomeScreen> extends State<T> {
  var columns = 1, rows = 1;
  double? horizontalPosition, verticalPosition;

  void onUpdateHorizontalPointer(double dx) {
    setState(() {
      horizontalPosition = dx;
    });
  }

  void onUpdateVerticalPointer(double dy) {
    setState(() {
      verticalPosition = dy;
    });
  }

  void onUpdateRows(int rows) {
    if (this.rows == rows) return;
    setState(() {
      this.rows = rows;
    });
  }

  void onUpdateColumn(int columns) {
    if (this.columns == columns) return;
    setState(() {
      this.columns = columns;
    });
  }
}