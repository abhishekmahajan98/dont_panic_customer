import 'package:call_number/call_number.dart';
import 'package:dont_panic_customer/constants.dart';
import 'package:dont_panic_customer/models/misc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpNumbersPage extends StatefulWidget {
  @override
  _HelpNumbersPageState createState() => _HelpNumbersPageState();
}

class _HelpNumbersPageState extends State<HelpNumbersPage> {
  void _initCall(num) async {
    await new CallNumber().callNumber('+91' + '$num');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Helpline numbers'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ngo.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
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
                  FontAwesomeIcons.phone,
                  color: mainColor,
                ),
                onPressed: () {
                  _initCall(ngo_contacts[index].toString());
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
