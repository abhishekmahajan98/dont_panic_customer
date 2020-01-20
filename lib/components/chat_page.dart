import 'package:connectivity/connectivity.dart';
import 'package:dont_panic_customer/constants.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Chat'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Steps to connect',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Card(
              child: ListTile(
                leading: Text(
                  'Step 1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
                title: Text('Disable mobile internet if enabled.'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Card(
              child: ListTile(
                leading: Text(
                  'Step 2',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
                title: Text('Click on Wifi in your settings'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Card(
              child: ListTile(
                leading: Text(
                  'Step 3',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
                title: Text('Disconnect to any other wifi .'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Card(
              child: ListTile(
                leading: Text(
                  'Step 4',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
                title: Text('Connect to wifi named \'Chat with me\''),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Card(
              child: ListTile(
                leading: Text(
                  'Step 5',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
                title: Text('Click on Chat below'),
              ),
            ),
          ),
          Center(
            child: Container(
              child: RaisedButton(
                color: mainColor,
                onPressed: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.wifi) {
                    Navigator.pushNamed(context, '/chat_webview');
                  } else {
                    Navigator.pushNamed(context, '/offline_page');
                  }
                },
                child: Text(
                  'Chat',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
