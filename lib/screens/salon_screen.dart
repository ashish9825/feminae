import 'package:feminae/constants.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class SalonScreen extends StatefulWidget {
  static String id = 'salon_screen';
  @override
  _SalonScreenState createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen>
    with SingleTickerProviderStateMixin {
  bool _showAppBar = false;
  ScrollController _scrollController = ScrollController();
  bool isScrollingDown = true;

  void myScroll() async {
    _scrollController.addListener(() {
      setState(() {});
      // if (_scrollController.position.userScrollDirection ==
      //     ScrollDirection.reverse) {
      //   _showAppBar = true;
      // }

      // if (_scrollController.position.userScrollDirection ==
      //     ScrollDirection.forward) {
      //   _showAppBar = false;
      // }
      //checkVisibility();
    });
  }

  @override
  void initState() {
    super.initState();
    myScroll();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: SizeConfig.blockSizeVertical * 40,
                floating: false,
                pinned: true,
                title: animatedTitle(),
                flexibleSpace: FlexibleSpaceBar(
                  background: topOfTheScreen(),
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.0,
                children: salonFacilities
                    .map((item) => Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFD2EBE5),
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
                                               offset: Offset(0,5),           child: Row(
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
                        ))
                    .toList(),
              ),
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

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  Widget topOfTheScreen() {
    return VisibilityDetector(
      key: Key("Unique Key"),
      onVisibilityChanged: (VisibilityInfo info) {
        setState(() {
          if (info.visibleFraction == 0.0) {
            _showAppBar = true;
          }

          if (info.visibleFraction > 0.0) {
            _showAppBar = false;
          }
        });
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'BEAUTY',
                  style: TextStyle(
                      color: Color(0xFF4D54BE),
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.safeBlockHorizontal * 6),
                ),
                Text(
                  'SALON',
                  style: TextStyle(
                      color: Color(0xFF4C54BD),
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.safeBlockHorizontal * 6),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'images/salon.svg',
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
      child: Text('Salon at home'),
    );
  }

  Widget buildSalonGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: salonFacilities
          .map((item) => Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        height: SizeConfig.blockSizeHorizontal * 10,
                        decoration: BoxDecoration(
                          color: Color(0xFFD2EBE5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 8),
                                blurRadius: 8),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(
                        item[1],
                      )
                    ],
                  ),
                ],
              ))
          .toList(),
    );
  }
}
