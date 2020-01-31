import 'package:feminae/utils/app_style.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: screenBody(),
        ),
      ),
    );
  }

  Widget screenBody() {
    return Column(

      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 30,
              child: Text(
                'Ashish Panjwani',
                style: headingStyle,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 40,
                height: SizeConfig.blockSizeHorizontal * 40,
                child: Image.asset(
                  'images/ashish.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        GridView.builder(
          padding: EdgeInsets.all(40.0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 4,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(20.0),
                          child: Container(
margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                color: Color(0xFFd9d9d9),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/room_heater.svg',
                      height: SizeConfig.blockSizeHorizontal * 10,
                      width: SizeConfig.blockSizeHorizontal * 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
