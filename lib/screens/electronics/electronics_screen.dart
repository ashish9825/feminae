import 'package:feminae/constants.dart';
import 'package:feminae/screens/cleaning/cleaning_screen_details.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class ElectronicsScreen extends StatefulWidget {
  static String id = 'electronics_screen';

  @override
  _ElectronicsScreenState createState() => _ElectronicsScreenState();
}

class _ElectronicsScreenState extends State<ElectronicsScreen> {
  bool _showAppBar = false;
  ScrollController _scrollController = ScrollController();
  bool isScrollingDown = true;

  @override
  void initState() {
    super.initState();
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
              SliverList(
                delegate: SliverChildListDelegate(
                  buildElectronicsList(),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ELECTRONICS',
                  style: TextStyle(
                      color: Color(0xFF6a52ad),
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.safeBlockHorizontal * 6),
                ),
                Text(
                  'SERVICES',
                  style: TextStyle(
                      color: Color(0xFF614A9E),
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.safeBlockHorizontal * 6),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'images/electronics.svg',
                height: SizeConfig.blockSizeHorizontal * 50,
                width: SizeConfig.blockSizeHorizontal * 50,
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
        'Electronics',
        style: appBarTextStyle,
      ),
    );
  }

  List<Widget> buildElectronicsList() {
    return electronics
        .map((item) => InkWell(
              onTap: () {
                int index;
                if (item[1] == 'Electricians')
                  index = 0;
                else if (item[1] == 'Appliance Repair') index = 1;

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => CleaningDetail(
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
                      height: SizeConfig.blockSizeHorizontal*30,
                      decoration: BoxDecoration(
                        color: Color(0xFFcfbddb),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SvgPicture.asset(
                              item[0],
                              width: SizeConfig.blockSizeHorizontal * 20,
                              height: SizeConfig.blockSizeHorizontal * 20,
                            ),
                          ),
                          Container(
                            child: Text(
                              item[1],
                              style: electronicsCardStyle,
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

  @override
  void dispose() {
    _scrollController.removeListener(() {}); 
    super.dispose();
  }
}
