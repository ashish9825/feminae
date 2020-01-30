import 'package:feminae/constants.dart';
import 'package:feminae/screens/electronics/appliance_screen_detail.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ApplianceScreen extends StatefulWidget {
  static String id = 'appliance_screen';

  @override
  _ApplianceScreenState createState() => _ApplianceScreenState();
}

class _ApplianceScreenState extends State<ApplianceScreen> {
  bool _showAppBar = false;
  ScrollController _scrollController = ScrollController();
  bool isScrollingDown = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: SizeConfig.blockSizeVertical * 40,
                floating: false,
                pinned: true,
                leading: _showAppBar ? null : Container(),
                title: animatedTitle(),
                flexibleSpace: FlexibleSpaceBar(
                  background: topOfTheScreen(),
                ),
              ),
              SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.0,
                  children: buildElectricianGrid()),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => SizedBox(
                    height: 20.0,
                  ),
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topOfTheScreen() {
    return VisibilityDetector(
      key: Key("Unique Key"),
      onVisibilityChanged: (VisibilityInfo info) {
        if (this.mounted) {
          setState(() {
            if (info.visibleFraction == 0.0) {
              _showAppBar = true;
            }

            if (info.visibleFraction > 0.0) {
              _showAppBar = false;
            }
          });
        }
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'APPLIANCE',
                    style: TextStyle(
                        color: Color(0xFFe60400),
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                  Text(
                    'REPAIR',
                    style: TextStyle(
                        color: Color(0xFFcc0300),
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.safeBlockHorizontal * 6),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'images/appliance_head.svg',
                  height: SizeConfig.blockSizeHorizontal * 50,
                  width: SizeConfig.blockSizeHorizontal * 50,
                ),
              ),
            ),
          ]),
    );
  }

  Widget animatedTitle() {
    return AnimatedOpacity(
      opacity: _showAppBar ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Text(
        'Appliance Repair',
        style: appBarTextStyle,
      ),
    );
  }

  List<Widget> buildElectricianGrid() {
    return applianceRepair
        .map((item) => InkWell(
              onTap: () {
                int index;
                if (item[1] == 'Washing Machine Repair')
                  index = 0;
                else if (item[1] == 'AC Service & Repair')
                  index = 1;
                else if (item[1] == 'Geyser Repair')
                  index = 2;
                else if (item[1] == 'Microwave Repair')
                  index = 3;
                else if (item[1] == 'Refrigerator Repair')
                  index = 4;
                else if (item[1] == 'Stove & Chimney Repair')
                  index = 5;
                else if (item[1] == 'Television Repair')
                  index = 6;
                else if (item[1] == 'Water Purifier Repair')
                  index = 7;
                else if (item[1] == 'Computer Systems Repairing') index = 8;

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => ApplianceDetail(
                      tabIndex: index,
                    ),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(
                      opacity: anim,
                      child: child,
                    ),
                    transitionDuration: Duration(milliseconds: 100),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFfce99c),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 8),
                              blurRadius: 8),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SvgPicture.asset(
                              item[0],
                              width: SizeConfig.blockSizeHorizontal * 10,
                              height: SizeConfig.blockSizeHorizontal * 10,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item[1],
                              style: salonCardTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
