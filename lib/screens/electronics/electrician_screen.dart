import 'package:feminae/screens/electronics/electrician_screen_detail.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:feminae/constants.dart';

class ElectricianScreen extends StatefulWidget {
  static String id = 'electrician_screen';

  final String token;
  ElectricianScreen(this.token);
  @override
  _ElectricianScreenState createState() => _ElectricianScreenState();
}

class _ElectricianScreenState extends State<ElectricianScreen> {
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
                    'ELECTRICAL',
                    style: TextStyle(
                        color: Color(0xFF808080),
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                  Text(
                    'OPERATIONS',
                    style: TextStyle(
                        color: Color(0xFF7e7e7e),
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
                  'images/electrician_head.svg',
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
        'Electricians',
        style: appBarTextStyle,
      ),
    );
  }

  List<Widget> buildElectricianGrid() {
    return electricianServices
        .map((item) => InkWell(
              onTap: () {
                int index;
                if (item[1] == 'Switch & Socket')
                  index = 0;
                else if (item[1] == 'Fan')
                  index = 1;
                else if (item[1] == 'Light')
                  index = 2;
                else if (item[1] == 'Chandelier')
                  index = 3;
                else if (item[1] == 'Inverter & Stabilizer')
                  index = 4;
                else if (item[1] == 'Wiring')
                  index = 5;
                else if (item[1] == 'Door Bell')
                  index = 6;
                else if (item[1] == 'Drill & Put')
                  index = 7;
                else if (item[1] == 'Heater') index = 8;

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => ElectricianDetail(
                      tabIndex: index,
                      token: widget.token,
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
                        color: Color(0xFFd9d9d9),
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
