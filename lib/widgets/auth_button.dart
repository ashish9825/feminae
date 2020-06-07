import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthButton extends StatelessWidget {
  AuthButton(this.state, this.authName);

  final int state;
  final String authName;

  @override
  Widget build(BuildContext context) {
    if (state == 0) {
      return Text(
        authName,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins-Bold",
            fontSize: 18.0,
            letterSpacing: 1.0),
      );
    } else {
      return SpinKitChasingDots(
        color: Colors.white,
        size: 20.0,
      );
    }
  }
}
