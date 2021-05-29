import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  LoginBackground({this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      // for the pictures on the welcome page later on
      child: SingleChildScrollView(
        child: Stack(
          children: [child],
        ),
      ),
    );
  }
}
