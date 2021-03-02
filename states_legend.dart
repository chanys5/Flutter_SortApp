import 'package:flutter/material.dart';
import 'sort_obj.dart';

class StatesLegend extends StatelessWidget {
  StatesLegend({this.legend});

  final List<SortState> legend;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < legend.length; ++i)
          Container(
            width: 100,
            height: 25,
            child: Container(
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: sortStateColors[legend[i]],
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      color: sortStateColors[legend[i]], height: 15, width: 15),
                  Text('${sortStateNames[legend[i]]}')
                ],
              ),
            ),
          ),
      ],
    );
  }
}
