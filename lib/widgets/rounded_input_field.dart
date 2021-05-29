import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final Widget child;

  RoundedInputField({this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
