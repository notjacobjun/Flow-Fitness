import 'package:flutter/material.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';

class AwardsScreen extends StatefulWidget {
  static const routeName = '/awards';

  @override
  _AwardsScreenState createState() => _AwardsScreenState();
}

class _AwardsScreenState extends State<AwardsScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: AppBar(
        title: Text("Awards"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      drawer: DetailDrawer(context),
      body: Column(
        children: [],
      ),
    );
  }
}
