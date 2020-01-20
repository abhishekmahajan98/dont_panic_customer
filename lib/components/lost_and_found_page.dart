import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dont_panic_customer/constants.dart';
import 'package:flutter/material.dart';

final _firestore = Firestore.instance;

class LostAndFound extends StatefulWidget {
  @override
  _LostAndFoundState createState() => _LostAndFoundState();
}

class _LostAndFoundState extends State<LostAndFound> {
  String name = '';
  String appxHeight = '';
  String age = '';
  String birthMark = '';
  String placeOfLost = '';
  String phoneNumber = "";
  String complexion = "";
  String hairColour = "";
  String additionalDetails = "";
  String lostorFound = "";
  String lostOrFoundGroup = 'Lost';
  Widget _buildTF(String label, Function getValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: getValue,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: mainColor),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
          labelText: label,
          contentPadding: EdgeInsets.only(top: 14.0, left: 44.0),
        ),
      ),
    );
  }

  Widget _buildTFNumber(String label, Function getValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: getValue,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: mainColor),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: mainColor)),
          labelText: label,
          contentPadding: EdgeInsets.only(top: 14.0, left: 44.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Lost or Found'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Lost:',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Radio(
                      value: 'Lost',
                      groupValue: lostOrFoundGroup,
                      activeColor: mainColor,
                      onChanged: (vl) {
                        print(vl);
                        setState(() {
                          lostOrFoundGroup = vl;
                          lostorFound = vl;
                        });
                      }),
                  Text(
                    'Found:',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Radio(
                      value: 'Found',
                      groupValue: lostOrFoundGroup,
                      activeColor: mainColor,
                      onChanged: (vl) {
                        print(vl);
                        setState(() {
                          lostOrFoundGroup = vl;
                          lostorFound = vl;
                        });
                      }),
                ],
              ),
            ),
            _buildTF(
              "Name",
              (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            _buildTFNumber(
              "Age",
              (value) {
                setState(() {
                  age = value;
                });
              },
            ),
            _buildTFNumber(
              "Approx. Height",
              (value) {
                setState(() {
                  appxHeight = value;
                });
              },
            ),
            _buildTF(
              "Birthmark",
              (value) {
                setState(() {
                  birthMark = value;
                });
              },
            ),
            _buildTF(
              "Place where lost/found",
              (value) {
                setState(() {
                  placeOfLost = value;
                });
              },
            ),
            _buildTFNumber(
              "Phone Number",
              (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
            _buildTF(
              "Complexion",
              (value) {
                setState(() {
                  complexion = value;
                });
              },
            ),
            _buildTF(
              "Hair Colour",
              (value) {
                setState(() {
                  hairColour = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    additionalDetails = value;
                  });
                },
                maxLines: 4,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: mainColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor)),
                  labelText: "Additional Details",
                  contentPadding: EdgeInsets.only(top: 14.0, left: 44.0),
                ),
              ),
            ),
            RaisedButton(
              color: mainColor,
              onPressed: () {
                _firestore.collection('lost').document().setData({
                  'Name': name,
                  'Age': age,
                  'Appx Height': appxHeight,
                  'birthmark': birthMark,
                  'place of lost': placeOfLost,
                  'phone number': phoneNumber,
                  'complexion': complexion,
                  'hair colour': hairColour,
                  'lostorfound': lostorFound
                });
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height / 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
