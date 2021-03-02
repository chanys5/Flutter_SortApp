import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';
import 'dart:math';
import 'states_legend.dart';
import 'size_config.dart';

class QuickSort extends StatefulWidget {
  @override
  _QuickSortState createState() => _QuickSortState();
}

class _QuickSortState extends State<QuickSort> {
  bool sorted = false;
  bool stopSort = false;
  List<SortObject> numbers = [];
  double speedMultipler = 1;
  SortStats stats;

  List<SortState> stateList = [
    SortState.open,
    SortState.sorting,
    SortState.sorted,
    SortState.pivot,
    SortState.swapping,
  ];

  Duration genDuration = Duration(milliseconds: 2);
  @override
  void initState() {
    super.initState();
    Future ft = Future(() {});
    int max = 5 + Random().nextInt(45);

    for (int i = 0; i < max; ++i) {
      ft = ft.then((_) {
        return Future.delayed(genDuration, () {
          numbers.add(SortObject());
          setState(() {});
        });
      });
    }

    stats = SortStats();
  }

  Future generate() async {
    sorted = false;
    stopSort = false;
    int length = numbers.length;

    for (int i = 0; i < length; ++i) {
      numbers.removeAt(numbers.length - 1);

      setState(() {});
      await Future.delayed(genDuration);
    }

    stats = SortStats();

    int max = 5 + Random().nextInt(45);
    for (int i = 0; i < max; ++i) {
      numbers.add(SortObject());

      setState(() {});
      await Future.delayed(genDuration);
    }

    setState(() {});
  }

  Future sort() async {
    if (sorted) return;
    sorted = true;

    await sortHelper(0, numbers.length - 1);

    for (var i = 0; i < numbers.length; ++i)
      numbers[i].state = SortState.sorted;

    setState(() {});
  }

  Future sortHelper(int start, int end) async {
    Duration dur = Duration(milliseconds: 500 ~/ speedMultipler);
    if (start < end) {
      int pivot = end;
      int i = start;

      numbers[pivot].state = SortState.pivot;

      for (int j = start; j < end; ++j) {
        if (numbers[j].value <= numbers[pivot].value) {
          // swap
          var tmp = numbers[j];
          numbers[j] = numbers[i];
          numbers[i] = tmp;

          numbers[j].state = SortState.swapping;
          numbers[i].state = SortState.swapping;

          setState(() {});
          await Future.delayed(dur);

          numbers[j].state = SortState.open;
          numbers[i].state = SortState.open;
          ++i;

          ++stats.swaps;
        }

        numbers[j].state = SortState.sorting;
        numbers[i].state = SortState.sorting;

        setState(() {});
        await Future.delayed(dur);

        numbers[j].state = SortState.open;
        numbers[i].state = SortState.open;

        ++stats.iterations;
      }

      numbers[pivot].state = SortState.open;

      setState(() {});
      await Future.delayed(dur);

      // Swap with last element
      var tmp = numbers[i];
      numbers[i] = numbers[end];
      numbers[end] = tmp;

      ++stats.swaps;

      numbers[i].state = SortState.pivot;
      numbers[end].state = SortState.pivot;

      setState(() {});
      await Future.delayed(dur);

      numbers[i].state = SortState.open;
      numbers[end].state = SortState.open;

      pivot = i;

      await sortHelper(start, pivot - 1);
      await sortHelper(pivot + 1, end);
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = SizeConfig.screenHeight * 0.65;
    double scrollableHeight = (SizeConfig.widgetSize) *
        (1 + (numbers.length ~/ SizeConfig.maxWidthWidgets));

    scrollableHeight = scrollableHeight > containerHeight
        ? scrollableHeight
        : containerHeight * 1.25;

    return Scaffold(
      appBar: AppBar(title: Text("Quick Sort"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: containerHeight,
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: scrollableHeight,
                  ),
                  for (var i = 0; i < numbers.length; ++i)
                    SortWidget(
                      key: numbers[i].key,
                      index: i,
                      number: numbers[i],
                      speedMultipler: speedMultipler,
                    ),
                ],
              ),
            ),
          ),
          StatesLegend(legend: stateList),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(child: Text('Sort'), onPressed: sort),
              ElevatedButton(child: Text('Generate'), onPressed: generate),
              Slider(
                  min: 0.1,
                  max: 5,
                  label: speedMultipler.round().toString(),
                  value: speedMultipler,
                  onChanged: (double value) {
                    setState(() {
                      speedMultipler = value;
                    });
                  }),
            ],
          )
        ],
      ),
    );
  }
}
