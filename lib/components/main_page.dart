import 'package:dont_panic_customer/components/cyclone_page.dart';
import 'package:dont_panic_customer/components/default_main_page.dart';
import 'package:dont_panic_customer/components/drought_page.dart';
import 'package:dont_panic_customer/components/earthquake_page.dart';
import 'package:dont_panic_customer/components/epidemic_page.dart';
import 'package:dont_panic_customer/components/flood_page.dart';
import 'package:dont_panic_customer/components/nuclear_disaster_page.dart';
import 'package:dont_panic_customer/components/tsunami_page.dart';
import 'package:dont_panic_customer/components/wildfire_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
  @override
  Widget build(BuildContext context) {
    return calamities[0];
  }
}
