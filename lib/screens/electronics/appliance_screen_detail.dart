import 'package:feminae/constants.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:flutter/material.dart';

class ApplianceDetail extends StatefulWidget {
  static String id = 'appliance_detail_screen';

  final tabIndex;
  final String token;

  const ApplianceDetail({Key key, this.tabIndex, @required this.token}) : super(key: key);

  @override
  _ApplianceDetailState createState() => _ApplianceDetailState();
}

class _ApplianceDetailState extends State<ApplianceDetail>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

@override
  void initState() {
    super.initState();
     _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 9, initialIndex: widget.tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                'Appliance Repair',
                style: appBarTextStyle,
              ),
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs:
                    applianceRepair.map((item) => Tab(text: item[1])).toList(),
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
          children: applianceRepair.map((item) => Text(item[1])).toList(),
          controller: _tabController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }
}
