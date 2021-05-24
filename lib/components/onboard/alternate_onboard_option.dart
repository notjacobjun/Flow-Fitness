import 'package:flutter/material.dart';

class AlternateOnBoardOption extends StatelessWidget {
  const AlternateOnBoardOption({
    Key key,
    @required this.size,
    @required this.message,
    @required this.buttonContent,
    @required this.nextScreen,
  }) : super(key: key);

  final String message;
  final String buttonContent;
  final Size size;
  final String nextScreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an Account?"),
        SizedBox(
          width: size.width * 0.02,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(nextScreen);
          },
          child: Text(
            buttonContent,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
