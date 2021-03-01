import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';

class InsertionSort extends StatefulWidget {
  @override
  _InsertionSortState createState() => _InsertionSortState();
}

class _InsertionSortState extends State<InsertionSort> {
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

    int prevIndex0 = 0;

    const Duration dur = Duration(milliseconds: 500);

    for (int i = 1; i < numbers.length; ++i) {
      var key = numbers[i];
      int j = i - 1;

      numbers[prevIndex0].state = SortState.open;
      prevIndex0 = j;
      numbers[j].state = SortState.sorting;

      while (j >= 0 && numbers[j].value > key.value) {
        // Move back one
        var tmp = numbers[j + 1];
        numbers[j + 1] = numbers[j];
        numbers[j] = tmp;

        numbers[j + 1].state = SortState.swapping;
        numbers[j].state = SortState.sorting;

        setState(() {});
        await Future.delayed(dur);

        numbers[j + 1].state = SortState.open;
        numbers[j].state = SortState.open;

        --j;
      }

      numbers[j + 1] = key;

      setState(() {});
      await Future.delayed(dur);
    }

    for (var i = 0; i < numbers.length; ++i)
      numbers[i].state = SortState.sorted;

    setState(() {});
    sorted = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insertion Sort"), centerTitle: true),
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
