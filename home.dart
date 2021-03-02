import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'size_config.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<SortObj> sortObjs = [
      SortObj(sortAlgoName: "Bubble Sort", contextName: '/bubbleSort'),
      SortObj(sortAlgoName: "Selection Sort", contextName: '/selectionSort'),
      SortObj(sortAlgoName: "Insertion Sort", contextName: '/insertionSort'),
      SortObj(sortAlgoName: "Merge Sort", contextName: '/mergeSort'),
      SortObj(sortAlgoName: "Quick Sort", contextName: '/quickSort'),
      SortObj(sortAlgoName: "Counting Sort", contextName: '/countingSort'),
      SortObj(sortAlgoName: "Bogo Sort", contextName: '/bogoSort'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Sorting Algorithms"),
        centerTitle: true,
        leading: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/profilePage');
          },
          child: Icon(
            Icons.account_circle,
          ),
        ),
      ),
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
