import 'dart:math';
import 'package:flutter/material.dart';

class SortObj {
  SortObj({this.sortAlgoName, this.contextName});

  String sortAlgoName;
  String contextName;
}

enum SortState {
  open,
  checking,
  sorting,
  sorted,
  pivot,
  min,
  swapping,
  range,
}

final Map sortStateNames = {
  SortState.open: 'Default',
  SortState.sorted: 'Sorted',
  SortState.sorting: 'Iterating',
  SortState.min: 'Min',
  SortState.swapping: 'Swapping',
  SortState.range: 'Range',
  SortState.checking: 'Checking',
  SortState.pivot: 'Pivot',
};

final Map sortStateColors = {
  SortState.open: Colors.black54,
  SortState.sorted: Colors.greenAccent,
  SortState.sorting: Colors.green,
  SortState.min: Colors.blue,
  SortState.swapping: Colors.cyan,
  SortState.range: Colors.grey[900],
  SortState.checking: Colors.red,
  SortState.pivot: Colors.orange,
};

class SortObject {
  SortObject({int maxRand = 100})
      : key = GlobalKey(),
        value = Random().nextInt(maxRand) {
    state = SortState.open;
    color = Colors.black54;
  }

  int value;
  final GlobalKey key;
  SortState state;
  Color color;
}

class SortStats {
  SortStats()
      : swaps = 0,
        iterations = 0;
  int swaps;
  int iterations;
}
