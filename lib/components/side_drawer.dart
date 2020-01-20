import 'package:dont_panic_customer/constants.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: mainColor,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/share_location_page');
              },
              child: ListTile(
                title: Text('Panic'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
