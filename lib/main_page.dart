import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:speed_meter/speed_gauge.dart';
import 'package:geolocator/geolocator.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _speed = 0;
  final GlobalKey<KdGaugeViewState> _gaugeKey = GlobalKey<KdGaugeViewState>();
  // final  GlobalKey<State<StatefulWidget>>? _gaugeKey =  GlobalKey<State<StatefulWidget>>?();

  @override
  void initState() {
    print(_gaugeKey);
    super.initState();
    // Timer.periodic(Duration(milliseconds: 200), (timer) {
    //   setState(() {
    //     _speed += 1;
    //   });
    //   print(_speed);
    //   _gaugeKey.currentState
    //       ?.updateSpeed(_speed, animate: true, duration: Duration(seconds: 0));
    // });
    initPosition();
  }

  void initPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission are permanently.');
    }
    Position nowLocation = await Geolocator.getCurrentPosition();
    // print(
    //     'latitude: ${nowLocation.latitude} longitude: ${nowLocation.longitude} ');
    print(nowLocation.speed);
    final LocationSettings locationsettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 3,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationsettings)
            .listen((Position? position) async {
      Position? lastPostiion = await Geolocator.getLastKnownPosition();
      if (position != null && lastPostiion != null) {
        double distance = Geolocator.distanceBetween(lastPostiion.latitude,
            lastPostiion.longitude, position.latitude, position.longitude);
        setState(() {
          _speed = position.speed * 3600 / 1000 * 1.6;
        });
        _gaugeKey.currentState?.updateSpeed(_speed,
            animate: true, duration: Duration(seconds: 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Builder(builder: (context) {
          return SpeedGuage(
            guageKey: _gaugeKey,
          );
        }));
  }
}
