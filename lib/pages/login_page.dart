import 'package:dont_panic_customer/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  FirebaseUser loggedInUser;
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    instantiatePrefs();
    checkForPermissions();
  }

  void instantiatePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void checkForPermissions() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();
    ServiceStatus serviceStatus =
        await LocationPermissions().checkServiceStatus();
    PermissionStatus p;
    if (permission == PermissionStatus.unknown) {
      p = await LocationPermissions().requestPermissions();
    }
    if (serviceStatus == ServiceStatus.disabled) {
      Alert(
          context: context,
          title: 'Please enable your location services',
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay'),
            ),
          ]).show();
    }
    if (permission == PermissionStatus.denied) {
      Alert(
          context: context,
          title:
              'Please give us permission in application\'s settings to get your location to deliver your clothes right to you.',
          buttons: [
            DialogButton(
              onPressed: () async {
                bool isOpened = await LocationPermissions().openAppSettings();
              },
              child: Text('Open settings'),
            ),
          ]).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t\nPanic',
              style: TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontFamily: 'Amarante',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                elevation: 40.0,
                borderRadius: BorderRadius.circular(40.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      User.email = value;
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'Email ID',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0)))),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                elevation: 40.0,
                borderRadius: BorderRadius.circular(40.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: 'Password',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0)))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    buttonColor: Colors.white,
                    height: 45,
                    minWidth: 100,
                    child: RaisedButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                    ),
                  ),
                  ButtonTheme(
                    height: 45,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        try {
                          print('email:' + email + "   " + password);
                          final firebaseUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (firebaseUser != null) {
                            final currentFirebaseUser =
                                await _auth.currentUser();
                            loggedInUser = currentFirebaseUser;
                            User.email = loggedInUser.email;
                            User.uid = loggedInUser.uid;
                            prefs.setString('loggedInUserEmail', User.email);
                            prefs.setString('loggedInUserUid', User.uid);
                            Navigator.pushNamed(context, '/home_page');
                            print(loggedInUser.email + ' logged in!!');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
