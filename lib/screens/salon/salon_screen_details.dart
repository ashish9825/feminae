import 'package:feminae/utils/app_style.dart';
import 'package:flutter/material.dart';

class SalonDetail extends StatefulWidget {
  static String id = 'salon_details_screen';

  final tabIndex;

  const SalonDetail({Key key, this.tabIndex}) : super(key: key);

  @override
  _SalonDetailState createState() => _SalonDetailState();
}

class _SalonDetailState extends State<SalonDetail> with SingleTickerProviderStateMixin{

  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 7, initialIndex: widget.tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Salon at Home', style: appBarTextStyle,),
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs: <Tab>[
                  Tab(text: 'Waxing'),
                  Tab(text: 'Facial Cleanup',),
                  Tab(text: 'Bleach & Detan',),
                  Tab(text: 'Pedicure'),
                  Tab(text: 'Manicure'),
                  Tab(text: 'Hair Care',),
                  Tab(text: 'Threading',)
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
            Text('Waxing',),
            Text('Facial Cleanup'),
            Text('Bleach & Detan'),
            Text('Pedicure'),
            Text('Manicure'),
            Text('Hair Care'),
            Text('Threading'),
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