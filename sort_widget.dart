import 'package:flutter/material.dart';
import 'sort_obj.dart';
import 'size_config.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({Key key, this.index, this.number, this.speedMultipler})
      : super(key: key);

  final int index;
  final SortObject number;
  final double speedMultipler;

  Offset calculateOffset(
      double height, double width, double sideOffset, double widgetSize) {
    final newWidth = (width - sideOffset * 2);

    final int xMaxIndex = newWidth ~/ widgetSize;
    final int xIndex = index % xMaxIndex;

    final int yIndex = index ~/ xMaxIndex;

    return Offset(sideOffset + xIndex * widgetSize, yIndex * widgetSize);
  }

  // @override
  Widget build(BuildContext context) {
    final offset = calculateOffset(SizeConfig.screenHeight,
        SizeConfig.screenWidth, SizeConfig.sideOffset, SizeConfig.widgetSize);

    final Duration dur = Duration(milliseconds: 500 ~/ speedMultipler);

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
      _borderColor = Colors.cyan;
      _borderWidth = 5.0;
    } else if (number.state == SortState.checking) {
      _borderColor = Colors.red;
      _borderWidth = 5.0;
    } else if (number.state == SortState.range) {
      _borderColor = Colors.grey[900];
      _borderWidth = 5.0;
    } else if (number.state == SortState.pivot) {
      _borderColor = Colors.orange;
      _borderWidth = 5.0;
    } else {
      _borderColor = Colors.black54;
      _borderWidth = 1.0;
    }

    return AnimatedPositioned(
      duration: dur,
      curve: Curves.linear,
      left: offset.dx,
      top: offset.dy,
      child: SizedBox(
        width: SizeConfig.widgetSize,
        height: SizeConfig.widgetSize,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: 500),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _borderColor,
                  width: _borderWidth,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: dur,
                  curve: Curves.ease,
                  style: TextStyle(
                    fontSize: SizeConfig.widgetSize / 4,
                    color: Colors.black,
                  ),
                  child: Text(
                    number.value.toString(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
