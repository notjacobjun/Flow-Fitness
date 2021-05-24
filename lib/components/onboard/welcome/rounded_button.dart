import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String message;
  final Function function;
  final Color color;

  RoundedButton({this.message, this.function, this.color});

  @override
  Widget build(BuildContext context) {
    // consider passing size into the widget instead so that we don't have to rebuild
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              backgroundColor: color),
          onPressed: function,
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
