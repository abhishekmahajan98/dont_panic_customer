import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_panic_customer/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email = '';
  String password = '';
  String uid;
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    instantiatePrefs();
  }

  void instantiatePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.indigoAccent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Email',
                      contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'password',
                      contentPadding: EdgeInsets.only(top: 4.0, left: 44.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              RaisedButton(
                onPressed: () async {
                  try {
                    print('email:' + email + "   " + password);
                    final firebaseUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                    if (firebaseUser != null) {
                      final currentFirebaseUser = await _auth.currentUser();
                      loggedInUser = currentFirebaseUser;
                      User.email = loggedInUser.email;
                      User.uid = loggedInUser.uid;
                      //prefs.setString('loggedInUserEmail', User.email);
                      //prefs.setString('loggedInUserUid', User.uid);
                      Navigator.pushNamed(context, '/homepage');
                      print(loggedInUser.email + ' logged in!!');
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pushNamed(context, '/home_page');
                },
                child: Text('Sign-Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
