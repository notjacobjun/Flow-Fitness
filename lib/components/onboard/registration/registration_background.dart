import 'package:flutter/material.dart';

class RegistrationBackground extends StatelessWidget {
  final Widget child;

  RegistrationBackground({this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      // TODO implement the pictures and animations here
      child: SingleChildScrollView(
        child: Stack(
          children: [child],
        ),
      ),
    );
  }
}
