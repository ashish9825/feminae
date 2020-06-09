import 'package:feminae/utils/profile_clipper.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  ProfileScreen(this.token);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(child: screenSetUp());
  }

  Widget screenSetUp() {
    return Column(
      children: <Widget>[
        Container(
          width: SizeConfig.screenWidth,
          color: Color(0xFFf6f9ff),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              ClipOval(
                clipper: ProfileClipper(),
                child: Image.asset(
                  'images/ashish.jpeg',
                  width: SizeConfig.blockSizeHorizontal * 35,
                  height: SizeConfig.blockSizeHorizontal * 35,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Ashish Panjwani',
                style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 23.0),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            child: Container(
              color: Colors.white,
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0, top: 5.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Color(0xFFEFE8FA),
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                  child: Icon(
                                    AntDesign.tagso,
                                    size: SizeConfig.blockSizeHorizontal * 5,
                                    color: Color(0xFF661FCE),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'My Bookings',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16.0,
                                        color: Color(0xFF3F2770)),
                                  ))
                            ],
                          ),
                          Icon(
                            AntDesign.right,
                            size: SizeConfig.blockSizeHorizontal * 5,
                            color: Color(0xFF633898),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Color(0xFFEFE8FA),
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                  child: Icon(
                                    AntDesign.smileo,
                                    size: SizeConfig.blockSizeHorizontal * 5,
                                    color: Color(0xFF661FCE),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Help Desk',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16.0,
                                        color: Color(0xFF3F2770)),
                                  ))
                            ],
                          ),
                          Icon(
                            AntDesign.right,
                            size: SizeConfig.blockSizeHorizontal * 5,
                            color: Color(0xFF633898),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Color(0xFFEFE8FA),
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                  child: Icon(
                                    AntDesign.sharealt,
                                    size: SizeConfig.blockSizeHorizontal * 5,
                                    color: Color(0xFF661FCE),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Share',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16.0,
                                        color: Color(0xFF3F2770)),
                                  ))
                            ],
                          ),
                          Icon(
                            AntDesign.right,
                            size: SizeConfig.blockSizeHorizontal * 5,
                            color: Color(0xFF633898),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Color(0xFFEFE8FA),
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                  child: Icon(
                                    AntDesign.profile,
                                    size: SizeConfig.blockSizeHorizontal * 5,
                                    color: Color(0xFF661FCE),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'About',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16.0,
                                        color: Color(0xFF3F2770)),
                                  ))
                            ],
                          ),
                          Icon(
                            AntDesign.right,
                            size: SizeConfig.blockSizeHorizontal * 5,
                            color: Color(0xFF633898),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Color(0xFFEFE8FA),
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                  child: Icon(
                                    AntDesign.staro,
                                    size: SizeConfig.blockSizeHorizontal * 5,
                                    color: Color(0xFF661FCE),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Rate Us',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16.0,
                                        color: Color(0xFF3F2770)),
                                  ))
                            ],
                          ),
                          Icon(
                            AntDesign.right,
                            size: SizeConfig.blockSizeHorizontal * 5,
                            color: Color(0xFF633898),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                        onPressed: null,
                        child: Container(
                            child: Text(
                          'Log Out',
                          style: TextStyle(
                              fontFamily: 'Poppins-Medium', fontSize: 18.0),
                        )))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
