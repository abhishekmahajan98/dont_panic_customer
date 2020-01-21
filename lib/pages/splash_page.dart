import 'dart:async';

import 'package:dont_panic_customer/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _auth = FirebaseAuth.instance;

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      instantiateSP();
    });
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
    checkLoggedInStatus();
  }

  void checkLoggedInStatus() async {
    if (prefs.containsKey('loggedInUserEmail')) {
      try {
        User.email = prefs.getString('loggedInUserEmail');
        User.uid = prefs.getString('loggedInUserUid');

        Navigator.pushReplacementNamed(context, '/home_page');
        //Navigator.pushReplacementNamed(context, '/test_page');
      } catch (e) {
        print(e);
        prefs.clear();
        _auth.signOut();
        Navigator.pushReplacementNamed(context, '/login_page');
      }
    } else {
      prefs.clear();
      _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
