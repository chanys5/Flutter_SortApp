import 'dart:math';
import 'package:flutter/material.dart';

class SortObj {
  SortObj({this.sortAlgoName, this.contextName});

  String sortAlgoName;
  String contextName;
}

enum SortState {
  open,
  sorting,
  sorted,
  pivot,
  min,
  swapping,
}

class SortObject {
  SortObject()
      : key = GlobalKey(),
        value = Random().nextInt(100) {
    state = SortState.open;
    color = Colors.black54;
  }

  final int value;
  final GlobalKey key;
  SortState state;
  Color color;
}

class SortStats {
  int swaps;
  int iterations;
}
