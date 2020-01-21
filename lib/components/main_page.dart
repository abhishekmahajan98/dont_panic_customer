import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_panic_customer/components/cyclone_page.dart';
import 'package:dont_panic_customer/components/default_main_page.dart';
import 'package:dont_panic_customer/components/drought_page.dart';
import 'package:dont_panic_customer/components/earthquake_page.dart';
import 'package:dont_panic_customer/components/epidemic_page.dart';
import 'package:dont_panic_customer/components/flood_page.dart';
import 'package:dont_panic_customer/components/nuclear_disaster_page.dart';
import 'package:dont_panic_customer/components/side_drawer.dart';
import 'package:dont_panic_customer/components/tsunami_page.dart';
import 'package:dont_panic_customer/components/wildfire_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:geolocator/geolocator.dart';

final _firestore = Firestore.instance;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Position position = Position(longitude: 80, latitude: 77);
  static String id = "";
  List calamities = [
    DefaultMainPage(),
    CyclonePage(),
    DroughtPage(),
    EarthquakePage(),
    TsunamiPage(),
    EpidemicPage(),
    WildfirePage(),
    FloodPage(),
    NuclearDisasterPage(),
  ];
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void getLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position.longitude == null || position.latitude == null) {
      position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      body: StreamBuilder(
        stream: _firestore.collection('calamities').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return calamities[0];
          }
          final docs = snapshot.data.documents;
          getLocation();
          double minDist = 1000000000;
          int minIdx = 0;
          for (var doc in docs) {
            GeoPoint gp = doc.data['geoLocation'];
            double dist = calculateDistance(position.latitude,
                position.longitude, gp.longitude, gp.latitude);
            if (dist < minDist) {
              minDist = dist;
              minIdx = doc.data['calamity code'];
            }
          }
          if (minDist < 20000) {
            return calamities[minIdx];
          } else {
            return calamities[0];
          }
        },
      ),
      //body: calamities[1],
    );
  }
}
