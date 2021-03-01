import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';

class QuickSort extends StatefulWidget {
  @override
  _QuickSortState createState() => _QuickSortState();
}

class _QuickSortState extends State<QuickSort> {
  bool sorted = false;
  List<SortObject> numbers = [
    SortObject(),
    SortObject(),
    SortObject(),
    SortObject(),
    SortObject(),
    SortObject(),
    SortObject(),
    SortObject(),
    SortObject(),
    SortObject(),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future sort() async {
    if (sorted) return;
    sorted = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quick Sort"), centerTitle: true),
      body: Center(
        child: Stack(
          children: <Widget>[
            for (var i = 0; i < numbers.length; ++i)
              SortWidget(key: numbers[i].key, index: i, number: numbers[i])
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: sort, child: Text("Sort")),
    );
  }
}
