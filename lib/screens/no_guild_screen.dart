import 'package:flutter/material.dart';

class NoGuildScreen extends StatelessWidget {
  static const routeName = "/no-guild";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text("Join a guild!"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Text(
                "It looks like you aren't in a guild. Try joining one now!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // TODO consider wrapping this in a glassmorphic container
            // TODO enter a list of recommended guilds here
          ],
        ));
  }
}
