import 'package:flutter/material.dart';

class RestScreen extends StatefulWidget {
  static const routeName = '/rest-screen';

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Column(
            children: [
              Text("Next workout: "),
            ],
          ),
        ),
      ),
    );
  }
}
