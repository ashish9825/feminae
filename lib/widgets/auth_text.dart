import 'package:flutter/material.dart';

class AuthText extends StatelessWidget {
  
  AuthText(this.authComponent, this.fontSize);

  final String authComponent;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      authComponent,
      style: TextStyle(
        fontFamily: "Poppins-Medium",
        fontSize: fontSize,
      ),
    );
  }
}