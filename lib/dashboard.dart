import 'package:feminae/screens/home.dart';
import 'package:feminae/screens/profile/personal_profile.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/bottom_navbar.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Dashboard extends StatefulWidget {
  static String id = 'dashboard_screen';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentTabIndex = 0;
  List<Widget> _children = [
    HomePage(),
    Container(color: Colors.blue),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: _children[_currentTabIndex],
            ),
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: SafeArea(right: false, child: createDrawer()),
      // ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _currentTabIndex,
        showElevation: false,
        items: [
          BottomNavBarItem(
            icon: Icon(Feather.home),
            title: Text('Home'),
            activeColor: Color(0xFF361070),
            inactiveColor: Color(0xFFb7b7c8),
          ),
          BottomNavBarItem(
            icon: Icon(AntDesign.setting),
            title: Text('Settings'),
            activeColor: Color(0xFF361070),
            inactiveColor: Color(0xFFb7b7c8),
          ),
          BottomNavBarItem(
            icon: Icon(SimpleLineIcons.user),
            title: Text('Profile'),
            activeColor: Color(0xFF361070),
            inactiveColor: Color(0xFFb7b7c8),
          ),
        ],
        onItemSelected: _onItemTapped,
      ),
    );
  }

  Widget createDrawer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.close, size: SizeConfig.blockSizeHorizontal * 7),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 10,
            top: SizeConfig.blockSizeHorizontal * 5,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 30,
                height: SizeConfig.blockSizeHorizontal * 30,
                child: Image.asset(
                  'images/ashish.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
          child: createDrawerItem(
            icon: Icon(AntDesign.setting),
            text: 'Settings',
            onTap: () {},
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
          child: createDrawerItem(
              icon: Icon(AntDesign.questioncircleo),
              text: 'Help Desk',
              onTap: () {}),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
          child: createDrawerItem(
              icon: Icon(AntDesign.logout), text: 'Log Out', onTap: () {}),
        ),
      ],
    );
  }

  Widget createDrawerItem(
      {@required Widget icon,
      @required String text,
      @required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon,
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
            child: Text(
              text,
              style: navItemTextStyle,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  // BottomNavigationBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(Feather.home),
  //           title: Container(),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(AntDesign.setting),
  //           title: Container(),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(SimpleLineIcons.user),
  //           title: Container(),
  //         ),
  //       ],
  //       currentIndex: _currentTabIndex,
  //       selectedIconTheme: IconThemeData(
  //         color: Colors.black,
  //         size: 26,
  //       ),
  //       onTap: _onItemTapped,
  //     ),
}