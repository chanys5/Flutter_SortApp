import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';

class BubbleSort extends StatefulWidget {
  @override
  _BubbleSortState createState() => _BubbleSortState();
}

class _BubbleSortState extends State<BubbleSort> {
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
    int prevIndex1 = 0;

    const Duration dur = Duration(milliseconds: 500);

    for (var i = 0; i < numbers.length; ++i) {
      bool swapped = false;
      for (var j = 0; j < numbers.length - 1; ++j) {
        // Set states
        numbers[prevIndex0].state = SortState.open;
        numbers[prevIndex1].state = SortState.open;

        prevIndex0 = j;
        prevIndex1 = j + 1;

        numbers[j].state = SortState.sorting;
        numbers[j + 1].state = SortState.sorting;

        if (numbers[j].value > numbers[j + 1].value) {
          // Swap
          final tmp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = tmp;

          numbers[j].state = SortState.swapping;
          numbers[j + 1].state = SortState.swapping;

          swapped = true;
        }

        setState(() {});
        await Future.delayed(dur);
      }

      if (swapped == false) break;
    }

    for (var i = 0; i < numbers.length; ++i) {
      numbers[i].state = SortState.sorted;
    }
    setState(() {});
    sorted = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bubble Sort"), centerTitle: true),
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
