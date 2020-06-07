import 'package:feminae/screens/search/search_location.dart';
import 'package:feminae/stack_example.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TopBar extends StatefulWidget {
  final String currentAddress;

  TopBar({this.currentAddress});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Row(
            children: <Widget>[
              SizedBox(width: SizeConfig.blockSizeHorizontal * 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Color(0xFFEFE8FA),
                  width: SizeConfig.blockSizeHorizontal * 15,
                  height: SizeConfig.blockSizeHorizontal * 15,
                  child: Image.asset(
                    'images/ashish.jpeg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Ashish Panjwani',
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: 15.0,
                      color: Color(0xFF210a43),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        AntDesign.enviromento,
                        size: SizeConfig.blockSizeHorizontal * 4,
                        color: Color(0xFFADA3C2),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal),
                      Text(
                        widget.currentAddress,
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 11.0,
                            color: Color(0xFF746297)),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 6),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 5,
                right: SizeConfig.blockSizeHorizontal * 5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RoutesWidget()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Search here',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 14.0,
                        color: Color(0xFF210a43)),
                  ),
                  Icon(AntDesign.search1,
                      size: SizeConfig.blockSizeHorizontal * 5,
                      color: Color(0xFFADA3C2))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 5,
                right: SizeConfig.blockSizeHorizontal * 5),
            child: Divider(
              color: Color(0xFFb3b3b3),
            ),
          ),
        ],
      ),
    );
  }
}
