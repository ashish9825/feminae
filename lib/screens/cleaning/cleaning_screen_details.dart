import 'package:feminae/constants.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:flutter/material.dart';

class CleaningDetail extends StatefulWidget {
  static String id = 'cleaning_screen_details';

  final tabIndex;
  final String token;

  const CleaningDetail({Key key, this.tabIndex, @required this.token}) : super(key: key);

  @override
  _CleaningDetailState createState() => _CleaningDetailState();
}

class _CleaningDetailState extends State<CleaningDetail>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController =
        TabController(vsync: this, length: 6, initialIndex: widget.tabIndex);
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
                'Cleaning Services',
                style: appBarTextStyle,
              ),
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs:
                    cleaningServices.map((item) => Tab(text: item[1])).toList(),
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
          children: cleaningServices.map((item) => Text(item[1])).toList(),
          controller: _tabController,
        ),
      ),
    );
  }
}
