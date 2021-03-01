import 'package:flutter/material.dart';
import 'sort_obj.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SortObj> sortObjs = [
      SortObj(sortAlgoName: "Bubble Sort", contextName: '/bubbleSort'),
      SortObj(sortAlgoName: "Selection Sort", contextName: '/selectionSort'),
      SortObj(sortAlgoName: "Insertion Sort", contextName: '/insertionSort'),
      SortObj(sortAlgoName: "Quick Sort", contextName: '/quickSort')
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Sorting Algorithms"), centerTitle: true),
      body: Center(
        child: ListView.separated(
            itemCount: sortObjs.length,
            itemBuilder: (context, int index) {
              return ListTile(
                  title: Text(sortObjs[index].sortAlgoName),
                  onTap: () {
                    Navigator.pushNamed(context, sortObjs[index].contextName);
                  });
            },
            separatorBuilder: (context, index) {
              return Divider();
            }),
      ),
    );
  }
}
