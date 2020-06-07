import 'package:feminae/bloc/auth_bloc.dart';
import 'package:feminae/dashboard.dart';
import 'package:feminae/screens/login_screeen.dart';
import 'package:feminae/screens/salon/salon_screen.dart';
import 'package:feminae/screens/salon/salon_screen_details.dart';
import 'package:feminae/screens/signup_screen.dart';
import 'package:feminae/stack_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(FeminaeApp());

class FeminaeApp extends StatelessWidget {
  final primaryColor = Color(0xFFee7f77);

  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      // initialRoute: LoginScreen.id,
      // routes: {
      //   LoginScreen.id: (context) => LoginScreen(),
      //   SignUpScreen.id: (context) => SignUpScreen(),
      //   Dashboard.id: (context) => Dashboard(),
      //   StackExample.id: (context) => StackExample(),
      //   SalonScreen.id: (context) => SalonScreen(),
      //   SalonDetail.id: (context) => SalonDetail(),
      // },
      home: initialScreen(),
    );
  }

  Widget initialScreen() {
    return StreamBuilder<String>(
      stream: authBloc.isSessionValid,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != 'None') {
          return Dashboard();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
