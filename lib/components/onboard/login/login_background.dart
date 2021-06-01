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
        child: Container(
          // just for visualization
          // color: Colors.black12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 15,
                child: Container(
                  // just for visualization
                  // color: Colors.black12,
                  height: size.height * 0.65,
                  width: size.width * 0.6,
                  child: Image(
                    image: AssetImage('assets/images/exercise.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
