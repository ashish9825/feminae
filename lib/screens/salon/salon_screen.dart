import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:feminae/bloc/facility_bloc.dart';
import 'package:feminae/model/facility_response.dart';
import 'package:feminae/widgets/error_widget.dart';
import 'package:feminae/widgets/loading_widget.dart';

class SalonScreen extends StatefulWidget {
  static String id = 'salon_screen';

  final String token;
  SalonScreen(this.token);
  @override
  _SalonScreenState createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen>
    with SingleTickerProviderStateMixin {
  bool _showAppBar = false;
  ScrollController _scrollController = ScrollController();
  bool isScrollingDown = true;

  @override
  void initState() {
    super.initState();
    bloc.getFacilities(widget.token, 'salon');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: showSalonFacilities(),
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
      child: Text(
        'Salon at Home',
        style: appBarTextStyle,
      ),
    );
  }

  Widget showSalonFacilities() {
    return StreamBuilder<FacilityResponse>(
      stream: bloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return FeminaeError(snapshot.data.error);
          }
          return salonList(snapshot.data);
        } else if (snapshot.hasError) {
          return FeminaeError(snapshot.error);
        } else {
          return FeminaeLoading();
        }
      },
    );
  }

  salonList(FacilityResponse data) {
    return CustomScrollView(
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
            children: List.generate(
              data.facilities.length,
              (index) => InkWell(
                onTap: () {
                  print(data.facilities[index].facility);
                  bloc.movetoTab(
                      int.parse(data.facilities[index].facilityId) - 1, context, widget.token);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Stack(
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
                        offset: Offset(0, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: SvgPicture.network(
                                data.facilities[index].facilityImage,
                                width: SizeConfig.blockSizeHorizontal * 10,
                                height: SizeConfig.blockSizeHorizontal * 10,
                                placeholderBuilder: (context) => Container(
                                  child: Icon(
                                    AntDesign.jpgfile1,
                                    size: SizeConfig.blockSizeHorizontal * 7,
                                    color: Color(0xFFFF7852),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                data.facilities[index].facility,
                                style: salonCardTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => SizedBox(
              height: 20.0,
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
