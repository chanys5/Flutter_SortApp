import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';
import 'dart:math';
import 'states_legend.dart';
import 'size_config.dart';

class MergeSort extends StatefulWidget {
  @override
  _MergeSortState createState() => _MergeSortState();
}

class _MergeSortState extends State<MergeSort> {
  bool sorted = false;
  bool stopSort = false;
  List<SortObject> numbers = [];
  double speedMultipler = 1;
  SortStats stats;

  List<SortState> stateList = [
    SortState.open,
    SortState.sorting,
    SortState.sorted,
    SortState.range,
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
      int mid = start + (end - start) ~/ 2;

      await sortHelper(start, mid);
      await sortHelper(mid + 1, end);

      numbers[start].state = SortState.range;
      numbers[mid].state = SortState.range;
      numbers[end].state = SortState.range;
      setState(() {});
      await Future.delayed(dur);

      await merge(start, mid, end, dur);

      numbers[start].state = SortState.open;
      numbers[mid].state = SortState.open;
      numbers[end].state = SortState.open;
      setState(() {});
      await Future.delayed(dur);
    }
  }

  Future merge(int start, int mid, int end, Duration dur) async {
    int start2 = mid + 1;

    setState(() {});
    await Future.delayed(dur);
    // Already sorted
    if (numbers[mid].value <= numbers[start2].value) {
      return;
    }
    int prevIndex = 0;
    while (start <= mid && start2 <= end) {
      numbers[prevIndex].state = SortState.open;
      prevIndex = start2;
      numbers[start2].state = SortState.sorting;

      stats.iterations++;

      setState(() {});
      await Future.delayed(dur);

      if (numbers[start].value <= numbers[start2].value) {
        start++;
      } else {
        int index = start2;

        while (index != start) {
          // Swap
          var tmp = numbers[index];
          numbers[index] = numbers[index - 1];
          numbers[index - 1] = tmp;

          numbers[index].state = SortState.swapping;
          numbers[index - 1].state = SortState.swapping;

          setState(() {});
          await Future.delayed(dur);

          numbers[index].state = SortState.open;
          numbers[index - 1].state = SortState.open;

          index--;
          stats.swaps++;
          stats.iterations++;
        }

        start++;
        mid++;
        start2++;
      }
    }

    numbers[prevIndex].state = SortState.open;
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
      appBar: AppBar(title: Text("Merge Sort"), centerTitle: true),
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
