import 'package:feminae/screens/home.dart';
import 'package:feminae/screens/profile/personal_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Dashboard extends StatefulWidget {
  static String id = 'dashboard_screen';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentTabIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentTabIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: HomePage(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Feather.getIconData('home')),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(AntDesign.getIconData('setting')),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.getIconData('user')),
            title: Container(),
          ),
        ],
        currentIndex: _currentTabIndex,
        selectedIconTheme: IconThemeData(
          color: Colors.black,
          size: 26,
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}
