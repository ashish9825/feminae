import 'package:feminae/constants.dart';
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
      // appBar: _showAppBar
      //     ? AppBar(
      //         title: Text('Salon for Women'),
      //         backgroundColor: Colors.white,
      //       )
      //     : PreferredSize(
      //         child: Container(),
      //         preferredSize: Size(0.0, 0.0),
      //       ),
      body: SafeArea(
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

            // SliverFillRemaining(
            //   child: buildSalonGrid(),
            // ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //       (context, index) => containerContent(),
            //       childCount: 1),
            // )
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 1.0,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: SizeConfig.blockSizeHorizontal * 20,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            salonFacilities[index][0],
                            width: SizeConfig.blockSizeHorizontal * 10,
                            height: SizeConfig.blockSizeHorizontal * 10,
                          ),
                        ),
                        Text(
                          salonFacilities[index][1],
                        )
                      ],
                    ),
                  ],
                );
              }, childCount: 7),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  Widget containerContent() {
    return Container(
      height: 50.0,
      color: Colors.cyanAccent,
      margin: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width - 100,
      child: Center(
        child: Text(
          'Item 1',
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }

  Widget body() {
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        topOfTheScreen(),
        buildSalonGrid(),
      ],
    );
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

  void checkVisibility() {
    VisibilityDetector(
      key: Key("Unique key"),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.size == Size.zero) {
          _showAppBar = true;
        }

        if (info.size > Size.zero) {
          _showAppBar = false;
        }
      },
      child: topOfTheScreen(),
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
