import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';

class SelectionSort extends StatefulWidget {
  @override
  _SelectionSortState createState() => _SelectionSortState();
}

class _SelectionSortState extends State<SelectionSort> {
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

    int minIndex;

    for (var i = 0; i < numbers.length; ++i) {
      minIndex = i;
      for (var j = i + 1; j < numbers.length; ++j) {
        // Set states
        numbers[prevIndex0].state = SortState.open;

        prevIndex0 = j;

        numbers[j].state = SortState.sorting;

        if (numbers[j].value < numbers[minIndex].value) {
          // Set min
          minIndex = j;
          //numbers[minIndex].state = SortState.min;
        }

        setState(() {});
        await Future.delayed(dur);
      }
      numbers[numbers.length - 1].state = SortState.open;

      // Swap with first index
      var tmp = numbers[i];
      numbers[i] = numbers[minIndex];
      numbers[minIndex] = tmp;

      numbers[i].state = SortState.swapping;
      numbers[minIndex].state = SortState.swapping;

      setState(() {});
      await Future.delayed(dur);

      numbers[i].state = SortState.sorted;
      numbers[minIndex].state = SortState.open;
    }

    for (var i = 0; i < numbers.length; ++i)
      numbers[i].state = SortState.sorted;

    setState(() {});
    sorted = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selection Sort"), centerTitle: true),
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
