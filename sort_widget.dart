import 'package:flutter/material.dart';
import 'sort_obj.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({Key key, this.index, this.number}) : super(key: key);

  final int index;
  final SortObject number;
  final double widgetSize = 75;

  // @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    var _borderColor = Colors.black54;
    var _borderWidth = 1.0;

    if (number.state == SortState.sorting) {
      _borderColor = Colors.green;
      _borderWidth = 5.0;
    } else if (number.state == SortState.sorted) {
      _borderColor = Colors.greenAccent;
      _borderWidth = 2.0;
    } else if (number.state == SortState.min) {
      _borderColor = Colors.blue;
    } else if (number.state == SortState.swapping) {
      _borderColor = Colors.red;
      _borderWidth = 5.0;
    } else if (number.state == SortState.pivot) {
      _borderColor = Colors.orange;
      _borderWidth = 5.0;
    } else {
      _borderColor = Colors.black54;
      _borderWidth = 1.0;
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      left: index.toDouble() * widgetSize,
      top: height / 2.5,
      child: SizedBox(
        width: widgetSize,
        height: widgetSize,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              border: Border.all(
                color: _borderColor,
                width: _borderWidth,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                style: TextStyle(
                  fontSize: 25,
                ),
                child: Text(
                  number.value.toString(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
