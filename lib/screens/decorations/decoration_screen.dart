import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

class DecorationScreen extends StatefulWidget {
  static String id = 'decoration_screen';
  @override
  _DecorationScreenState createState() => _DecorationScreenState();
}

class _DecorationScreenState extends State<DecorationScreen>
    with SingleTickerProviderStateMixin {
  bool _showAppBar = false;
  ScrollController _scrollController;
  bool isScrollingDown = true;

  @override
  void initState() {
    _scrollController = ScrollController();
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
              // SliverGrid.count(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 0,
              //     mainAxisSpacing: 10,
              //     childAspectRatio: 2.0,
              //     children: buildElectricianGrid()),
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
                    'DECORATIONS',
                    style: TextStyle(
                        color: Color(0xFFe60400),
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                  Text(
                    'AREA',
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
                  'images/decoration.svg',
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
        'Decorations',
        style: appBarTextStyle,
      ),
    );
  }
}
