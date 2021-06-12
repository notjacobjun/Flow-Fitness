import 'package:flutter/material.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';

class SocialScreen extends StatefulWidget {
  static const routeName = '/social';
  @override
  SocialScreenState createState() => SocialScreenState();
}

class SocialScreenState extends State<SocialScreen> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: AppBar(
        title: Text("Social"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      drawer: DetailDrawer(context),
      body: Column(
        children: [],
      ),
    );
  }
}
