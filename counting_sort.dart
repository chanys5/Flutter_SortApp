import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'sort_widget.dart';
import 'dart:math';
import 'states_legend.dart';
import 'size_config.dart';

class CountingSort extends StatefulWidget {
  @override
  _CountingSortState createState() => _CountingSortState();
}

class _CountingSortState extends State<CountingSort> {
  bool sorted = false;
  bool stopSort = false;
  final int maxNumCount = 10;
  List<SortObject> numbers = [];
  double speedMultipler = 1;
  SortStats stats;

  List<int> countList = [];

  List<SortState> stateList = [
    SortState.open,
    SortState.sorting,
    SortState.sorted,
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
          numbers.add(SortObject(maxRand: 10));
          setState(() {});
        });
      });
    }

    countList = List.filled(maxNumCount, 0);

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

    for (int i = 0; i < countList.length; ++i) {
      countList[i] = 0;
    }

    stats = SortStats();

    int max = 5 + Random().nextInt(45);

    for (int i = 0; i < max; ++i) {
      numbers.add(SortObject(maxRand: 10));

      setState(() {});
      await Future.delayed(genDuration);
    }

    setState(() {});
  }

  Future sort() async {
    if (sorted) return;
    sorted = true;

    Duration dur = Duration(milliseconds: 500 ~/ speedMultipler);
    int prevIndex = 0;

    for (var i = 0; i < numbers.length; ++i) {
      ++countList[numbers[i].value];

      numbers[prevIndex].state = SortState.open;
      prevIndex = i;
      numbers[i].state = SortState.sorting;

      stats.iterations++;

      setState(() {});
      await Future.delayed(dur);
    }

    numbers[prevIndex].state = SortState.open;

    for (var i = 1; i < countList.length; ++i) {
      countList[i] += countList[i - 1];

      stats.iterations++;

      setState(() {});
      await Future.delayed(dur);
    }

    List<int> tmpList = List.filled(numbers.length, 0);

    for (var i = 0; i < numbers.length; ++i) {
      tmpList[countList[numbers[i].value] - 1] = numbers[i].value;

      --countList[numbers[i].value];

      numbers[prevIndex].state = SortState.open;
      prevIndex = i;
      numbers[i].state = SortState.sorting;

      stats.iterations++;

      setState(() {});
      await Future.delayed(dur);
    }

    numbers[prevIndex].state = SortState.open;

    for (var i = 0; i < numbers.length; ++i) {
      numbers[i].value = tmpList[i];
      numbers[i].state = SortState.sorted;

      stats.iterations++;

      setState(() {});
      await Future.delayed(dur);
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = SizeConfig.screenHeight * 0.50;
    double scrollableHeight = (SizeConfig.widgetSize) *
        (1 + (numbers.length ~/ SizeConfig.maxWidthWidgets));

    scrollableHeight = scrollableHeight > containerHeight
        ? scrollableHeight
        : containerHeight * 1.25;

    return Scaffold(
      appBar: AppBar(title: Text("Counting Sort"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(alignment: WrapAlignment.center, children: [
              for (var i = 0; i < countList.length; ++i)
                SizedBox(
                  width: SizeConfig.widgetSize,
                  height: SizeConfig.widgetSize,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${countList[i]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      )),
                    ),
                  ),
                ),
            ]),
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
      ),
    );
  }
}
