import 'package:flutter/material.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_app_bar.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: RoundedAppBar(
        text: Text("Settings"),
      ),
      drawer: DetailDrawer(context),
      body: Column(
        children: [],
      ),
    );
  }
}
