import 'package:feminae/constants.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:flutter/material.dart';

class ElectricianDetail extends StatefulWidget {
  static String id = 'electrician_detail_screen';

  final tabIndex;

  const ElectricianDetail({Key key, this.tabIndex}) : super(key: key);

  @override
  _ElectricianDetailState createState() => _ElectricianDetailState();
}

class _ElectricianDetailState extends State<ElectricianDetail>
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
                'Electrician at Home',
                style: appBarTextStyle,
              ),
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs:
                    electricianServices.map((item) => Tab(text: item[1])).toList(),
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
          children: electricianServices.map((item) => Text(item[1])).toList(),
          controller: _tabController,
        ),
      ),
    );
  }
}
