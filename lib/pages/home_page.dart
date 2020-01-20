import 'package:audio/audio.dart';
import 'package:dont_panic_customer/components/chat_page.dart';
import 'package:dont_panic_customer/components/help_number_page.dart';
import 'package:dont_panic_customer/components/lost_and_found_page.dart';
import 'package:dont_panic_customer/components/main_page.dart';
import 'package:dont_panic_customer/components/radio_page.dart';
import 'package:dont_panic_customer/components/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer advancedPlayer;
  bool playAlarm = false;
  @override
  initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  final List<String> _pageTitles = [
    'Home',
    'Radio',
    'Lost and found',
    'Helpline Numbers',
    'Help Chat',
  ];
  final List<Widget> _pages = [
    MainPage(),
    Radiochat(),
    LostAndFound(),
    HelpNumbersPage(),
    ChatPage(),
  ];
  BottomNavigationBarItem _buildNavigationItem(
      int index, IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: Colors.black,
      ),
      activeIcon: Icon(
        iconData,
        color: Colors.indigoAccent,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.indigoAccent : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          _buildNavigationItem(0, FontAwesomeIcons.list, _pageTitles[0]),
          _buildNavigationItem(
              1, FontAwesomeIcons.broadcastTower, _pageTitles[1]),
          _buildNavigationItem(2, FontAwesomeIcons.book, _pageTitles[2]),
          _buildNavigationItem(3, FontAwesomeIcons.firstAid, _pageTitles[3]),
          _buildNavigationItem(4, FontAwesomeIcons.whatsapp, _pageTitles[4]),
        ],
      ),
      drawer: SideDrawer(),
      body: _pages[_selectedIndex],
    );
  }
}
