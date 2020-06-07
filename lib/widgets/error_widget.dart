import 'package:flutter/material.dart';

class FeminaeError extends StatelessWidget {
  final String error;

  FeminaeError(this.error);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error Occured: $error",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontFamily: "Poppins-Medium"),
          ),
        ],
      ),
    );
  }
}
