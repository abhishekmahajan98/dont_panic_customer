import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_panic_customer/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

final _firestore = Firestore.instance;

class ShareLocation extends StatefulWidget {
  @override
  _ShareLocationState createState() => _ShareLocationState();
}

void updateLoc(double lat, double long) async {
  DocumentSnapshot ds =
      await _firestore.collection('users').document('12345').get();
  if (ds.exists) {
    print('yes1');
    _firestore.collection('users').document('12345').updateData({
      'geoLocation': GeoPoint(lat, long),
      'updated': 'yes',
    });
  } else {
    print('yes2');
    _firestore.collection('users').document('12345').setData({
      'id': '12345',
      'updated': 'no',
      'geoLocation': GeoPoint(lat, long),
    });
  }
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
    updateLoc(position.latitude, position.longitude);
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: FlareActor(
                  "assets/flares/location.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "move",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Sharing location',
              style: TextStyle(
                  color: mainColor,
                  fontSize: MediaQuery.of(context).size.height / 30,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
