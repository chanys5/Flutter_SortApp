import 'package:flutter/material.dart';
import 'package:sort_app/quick_sort.dart';
import 'package:sort_app/selection_sort.dart';
import 'home.dart';
import 'bubble_sort.dart';
import 'selection_sort.dart';
import 'insertion_sort.dart';
import 'quick_sort.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/bubbleSort': (context) => BubbleSort(),
      '/selectionSort': (context) => SelectionSort(),
      '/insertionSort': (context) => InsertionSort(),
      '/quickSort': (context) => QuickSort(),
    },
  ));
}
