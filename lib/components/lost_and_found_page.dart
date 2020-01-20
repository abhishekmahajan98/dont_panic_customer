import 'package:cloud_firestore/cloud_firestore.dart';
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
  String lostOrFoundGroup = 'lost';
  Widget _buildTF(String label, Function getValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: getValue,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
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
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.teal)),
          labelText: label,
          contentPadding: EdgeInsets.only(top: 14.0, left: 44.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Row(
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
                    onChanged: (vl) {
                      print(vl);
                      setState(() {
                        lostOrFoundGroup = vl;
                        lostorFound = vl;
                      });
                    }),
              ],
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
              "Appx Height",
              (value) {
                setState(() {
                  appxHeight = value;
                });
              },
            ),
            _buildTF(
              "birthmark",
              (value) {
                setState(() {
                  birthMark = value;
                });
              },
            ),
            _buildTF(
              "place of lost",
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
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  labelText: "Additional Details",
                  contentPadding: EdgeInsets.only(top: 14.0, left: 44.0),
                ),
              ),
            ),
            RaisedButton(
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
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
