import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:speed_meter/main_page.dart';
import 'package:speed_meter/speed_gauge.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeedMeter'),
      ),
      body: MainPage(),
    );
  }
}
