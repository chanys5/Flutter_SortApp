import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';
import 'dart:math';
import 'states_legend.dart';
import 'size_config.dart';

class BogoSort extends StatefulWidget {
  @override
  _BogoSortState createState() => _BogoSortState();
}

class _BogoSortState extends State<BogoSort> {
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
    SortState.checking,
  ];

  Duration genDuration = Duration(milliseconds: 3);
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

    Duration dur = Duration(milliseconds: 500 ~/ speedMultipler);

    while (!isSorted()) {
      for (int i = 0; i < numbers.length; ++i) {
        numbers[i].state = SortState.checking;
      }
      setState(() {});
      await Future.delayed(dur);

      for (int i = 0; i < numbers.length; ++i) {
        numbers[i].state = SortState.open;
      }

      for (int i = 0; i < numbers.length; ++i) {
        int randIndex = Random().nextInt(numbers.length);

        // Swap
        var tmp = numbers[i];
        numbers[i] = numbers[randIndex];
        numbers[randIndex] = tmp;

        numbers[i].state = SortState.swapping;
        numbers[randIndex].state = SortState.swapping;

        stats.swaps++;

        setState(() {});
        await Future.delayed(dur);

        numbers[i].state = SortState.open;
        numbers[randIndex].state = SortState.open;

        stats.iterations++;
      }
    }

    for (var i = 0; i < numbers.length; ++i)
      numbers[i].state = SortState.sorted;

    setState(() {});
  }

  bool isSorted() {
    for (int i = 0; i < numbers.length - 1; ++i) {
      stats.iterations++;
      if (numbers[i].value > numbers[i + 1].value) {
        return false;
      }
    }
    return true;
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
      appBar: AppBar(title: Text("Bogo Sort"), centerTitle: true),
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
          ),
        ],
      ),
    );
  }
}
