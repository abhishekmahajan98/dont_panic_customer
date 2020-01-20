import 'package:dont_panic_customer/constants.dart';
import 'package:dont_panic_customer/models/misc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Radiochat extends StatefulWidget {
  @override
  _RadiochatState createState() => _RadiochatState();
}

class _RadiochatState extends State<Radiochat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Radio'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ngo.length,
        itemBuilder: (context, index) {
          return ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              child: Icon(
                Icons.healing,
              ),
            ),
            title: Text(ngo[index].toString()),
            subtitle: Text('Description for the ngo'),
            trailing: IconButton(
              icon: Icon(
                FontAwesomeIcons.microphoneAlt,
                color: mainColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
