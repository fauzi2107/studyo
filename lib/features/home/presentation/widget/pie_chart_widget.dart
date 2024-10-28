import '../../../../ui_export.dart';
import '../../../painter/chart/pie_chart_painter.dart';

class PieChart extends StatelessWidget {
  final List<double> values;  // Data for the pie chart
  final List<Color> colors;   // Colors for each slice
  final double size;

  const PieChart({super.key,
    required this.values,
    required this.colors,
    required this.size,
  }) : assert(values.length == colors.length, 'Values and colors must have the same length');

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),  // Set the desired size for the pie chart
      painter: PieChartPainter(
        values: values,
        colors: colors,
        spacing: 15,
        donutWidth: 25
      ),
    );
  }
}