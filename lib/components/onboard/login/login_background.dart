import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

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
        child: Container(
          // just for visualization
          // color: Colors.black12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/login-background.jpg'),
                fit: BoxFit.fill,
              ),
              GlassmorphicContainer(
                height: size.height * 0.5,
                width: size.width * 0.95,
                child: Center(child: child),
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
      ),
    );
  }
}
