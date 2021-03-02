import 'package:flutter/material.dart';

class SortSpeed extends StatefulWidget {
  SortSpeed({Key key}) : super(key: key);

  @override
  _SortSpeedState createState() => _SortSpeedState();
}

class _SortSpeedState extends State<SortSpeed> {
  double _speed = 0.5;

  double get speed => _speed;

  double getSpeed() {
    return _speed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Search Speed', style: Theme.of(context).textTheme.caption),
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Slider(
              label: _speed.round().toString(),
              value: _speed,
              onChanged: (double value) {
                setState(() {
                  _speed = value;
                });
              }),
        ),
      ],
    );
  }
}
