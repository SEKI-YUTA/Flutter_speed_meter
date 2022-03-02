import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';

class SpeedGuage extends StatefulWidget {
  late GlobalKey<State<StatefulWidget>>? guageKey;
  SpeedGuage({Key? key, required this.guageKey}) : super(key: key);
  @override
  State<SpeedGuage> createState() => _SpeedGuageState();
}

class _SpeedGuageState extends State<SpeedGuage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KdGaugeView(
      key: widget.guageKey,
      minSpeed: 0,
      maxSpeed: 180,
      speed: 0,
      speedTextStyle: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
      animate: true,
      // duration: Duration(seconds: 1),
      subDivisionCircleColors: Colors.red,
      divisionCircleColors: Colors.redAccent,
      fractionDigits: 0,
      activeGaugeColor: Colors.blue,
      alertColorArray: [Colors.green, Colors.yellow, Colors.red],
      alertSpeedArray: [40, 60, 100],
      unitOfMeasurement: 'Km/h',
    );
    // return Text(speed.toString());
  }
}
