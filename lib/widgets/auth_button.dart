import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  
  AuthButton(this.authName);

  final String authName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        authName,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins-Bold",
            fontSize: 18.0,
            letterSpacing: 1.0),
      ),
    );
  }
}