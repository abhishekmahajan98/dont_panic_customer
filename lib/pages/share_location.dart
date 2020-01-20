import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ShareLocation extends StatefulWidget {
  @override
  _ShareLocationState createState() => _ShareLocationState();
}

class _ShareLocationState extends State<ShareLocation> {
  static var geolocator = Geolocator();
  static var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  StreamSubscription<Position> positionStream =
      geolocator.getPositionStream(locationOptions).listen((Position position) {
    print(position == null
        ? 'Unknown'
        : position.latitude.toString() + ', ' + position.longitude.toString());
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Share location page'),
      ),
    );
  }
}
