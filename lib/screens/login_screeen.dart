import 'package:feminae/constants.dart';
import 'package:feminae/dashboard.dart';
import 'package:feminae/screens/signup_screen.dart';
import 'package:feminae/widgets/auth_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:feminae/widgets/auth_button.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog progressDialog;

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(
      message: 'Logging you in..',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
      elevation: 5.0,
      insetAnimCurve: Curves.decelerate,
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w400),
    );
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: Image.asset(
                  'images/women_image.png',
                  width: 256.0,
                  height: 240.0,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset('images/image_02.png')
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'images/logo.png',
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text(
                        "Feminae",
                        style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: ScreenUtil.getInstance().setSp(46),
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0),
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              fontFamily: "Poppins-Bold",
                              letterSpacing: .6,
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          AuthText("Email", ScreenUtil.getInstance().setSp(26)),
                          TextField(
                            decoration: kEmailInputDecoration,
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          AuthText(
                              "Password", ScreenUtil.getInstance().setSp(26)),
                          TextField(
                            obscureText: true,
                            decoration: kPasswordInputDecoration,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(35),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Color(0xFFee7f77),
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(24)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFFEC6F66), Color(0xFFF3A183)]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF3A183).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                progressDialog.show();
                                try {
                                  final currentUser =
                                      await _auth.signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );

                                  if (currentUser != null) {
                                    print('Sign in Successful !');
                                    if (progressDialog.isShowing())
                                      progressDialog.hide();
                                    Navigator.pushReplacementNamed(
                                        context, Dashboard.id);
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Center(
                                child: AuthButton("Sign In"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(170),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "New User ?",
                          style: TextStyle(fontFamily: "Poppins-Medium"),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xFFEC6F66),
                                fontFamily: "Poppins-Bold"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
