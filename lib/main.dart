import 'package:flutter/material.dart';
import 'package:studyo/features/painter/line_triangle/triangle_downward_painter.dart';
import 'package:studyo/features/painter/rectangle/interactive_rectangle.dart';

import 'features/painter/line_triangle/interactive_triangle.dart';
import 'features/painter/line_triangle/interactive_triangle_rightside.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var columns = 1, rows = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InteractiveLineWithTriangle(
              onChangeColumn: (totalColumn) {
                if (columns == totalColumn) return;
                setState(() {
                  columns = totalColumn;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InteractiveTriangleRightSide(
                  onChangeRow: (totalRow) {
                    if (rows == totalRow) return;
                    setState(() {
                      rows = totalRow;
                    });
                  },
                ),
                InteractiveRectangles(
                  totalColumn: columns,
                  totalRow: rows,
                ),
                InteractiveTriangleRightSide(
                  onChangeRow: (totalRow) {
                    if (rows == totalRow) return;
                    setState(() {
                      rows = totalRow;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
