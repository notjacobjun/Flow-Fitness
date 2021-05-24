import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  final Widget child;

  WelcomeBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      // for the pictures on the welcome page later on
      child: Stack(
        alignment: Alignment.center,
        children: [child],
      ),
    );
  }
}
