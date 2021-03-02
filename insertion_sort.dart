import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';
import 'dart:math';
import 'states_legend.dart';
import 'size_config.dart';

class InsertionSort extends StatefulWidget {
  @override
  _InsertionSortState createState() => _InsertionSortState();
}

class _InsertionSortState extends State<InsertionSort> {
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

        stats.swaps++;

        numbers[j + 1].state = SortState.open;
        numbers[j].state = SortState.open;

        --j;
      }

      stats.iterations++;

      numbers[j + 1] = key;

      setState(() {});
      await Future.delayed(dur);
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
      appBar: AppBar(title: Text("Insertion Sort"), centerTitle: true),
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
