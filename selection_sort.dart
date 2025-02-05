import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';
import 'dart:math';
import 'states_legend.dart';
import 'size_config.dart';

class SelectionSort extends StatefulWidget {
  @override
  _SelectionSortState createState() => _SelectionSortState();
}

class _SelectionSortState extends State<SelectionSort> {
  bool sorted = false;
  bool stopSort = false;
  List<SortObject> numbers = [];
  double speedMultipler = 1;
  SortStats stats;

  List<SortState> stateList = [
    SortState.open,
    SortState.sorting,
    SortState.sorted,
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
        }

        stats.iterations++;
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

      stats.swaps++;

      setState(() {});
      await Future.delayed(dur);

      numbers[i].state = SortState.sorted;
      numbers[minIndex].state = SortState.open;
    }

    for (var i = 0; i < numbers.length; ++i)
      numbers[i].state = SortState.sorted;

    setState(() {});
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
      appBar: AppBar(title: Text("Selection Sort"), centerTitle: true),
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
