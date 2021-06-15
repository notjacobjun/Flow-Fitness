import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class RegistrationBackground extends StatelessWidget {
  final Widget child;

  RegistrationBackground({this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      // for the pictures on the welcome page later on
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: size.width,
                height: size.height,
                child: Image.asset(
                  'assets/images/registration-background.jpg',
                  fit: BoxFit.fill,
                )),
            GlassmorphicContainer(
              child: Center(child: child),
              height: size.height * 0.65,
              width: size.width * 0.95,
              borderRadius: 50,
              blur: 200,
              alignment: Alignment.center,
              border: 0.65,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.1),
                    Color(0xFFFFFFFF).withOpacity(0.05),
                  ],
                  stops: [
                    0.1,
                    1,
                  ]),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.5),
                  Color((0xFFFFFFFF)).withOpacity(0.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
