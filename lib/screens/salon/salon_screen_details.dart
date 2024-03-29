import 'package:feminae/screens/salon/details_widget.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';

class SalonDetail extends StatefulWidget {
  static String id = 'salon_details_screen';

  final tabIndex;
  final String token;

  const SalonDetail({Key key, this.tabIndex, @required this.token})
      : super(key: key);

  @override
  _SalonDetailState createState() => _SalonDetailState();
}

class _SalonDetailState extends State<SalonDetail>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController =
        TabController(vsync: this, length: 7, initialIndex: widget.tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                'Salon at Home',
                style: appBarTextStyle,
              ),
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs: <Tab>[
                  Tab(text: 'Waxing'),
                  Tab(text: 'Facial Cleanup'),
                  Tab(text: 'Bleach & Detan'),
                  Tab(text: 'Pedicure'),
                  Tab(text: 'Manicure'),
                  Tab(text: 'Hair Care'),
                  Tab(text: 'Threading')
                ],
                controller: _tabController,
                indicatorColor: Color(0xFF3A499A),
                labelStyle: selectedTabStyle,
                unselectedLabelStyle: unSelectedTabStyle,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black45,
                isScrollable: true,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            DetailsPage(1, widget.token),
            DetailsPage(2, widget.token),
            DetailsPage(3, widget.token),
            DetailsPage(4, widget.token),
            DetailsPage(5, widget.token),
            DetailsPage(6, widget.token),
            DetailsPage(7, widget.token),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
