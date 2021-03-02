import 'package:flutter/material.dart';
import 'package:sort_app/profile_page.dart';
import 'package:sort_app/quick_sort.dart';
import 'package:sort_app/selection_sort.dart';
import 'home.dart';
import 'bubble_sort.dart';
import 'selection_sort.dart';
import 'insertion_sort.dart';
import 'quick_sort.dart';
import 'counting_sort.dart';
import 'merge_sort.dart';
import 'bogo_sort.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/bubbleSort': (context) => BubbleSort(),
      '/selectionSort': (context) => SelectionSort(),
      '/insertionSort': (context) => InsertionSort(),
      '/mergeSort': (context) => MergeSort(),
      '/quickSort': (context) => QuickSort(),
      '/countingSort': (context) => CountingSort(),
      '/bogoSort': (context) => BogoSort(),
      '/profilePage': (context) => ProfilePage(),
    },
  ));
}
