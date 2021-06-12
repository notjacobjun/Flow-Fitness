import 'package:flutter/material.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: AppBar(
        title: Text("Flow Fitness"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      drawer: DetailDrawer(context),
    );
  }
}
