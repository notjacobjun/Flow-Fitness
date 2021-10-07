import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/awards_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/home_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/settings_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/workout_categories_screen.dart';

class Destination {
  final Widget screen;
  final IconData icon;
  final String title;

  Destination({this.screen, this.icon, this.title});

  List<Destination> destionations = [
    Destination(screen: HomeScreen(), icon: Icons.home, title: "Home"),
    Destination(screen: AwardsScreen(), icon: Icons.home, title: "Home"),
    Destination(
        screen: WorkoutCategoriesScreen(), icon: Icons.home, title: "Home"),
    Destination(screen: SettingsScreen(), icon: Icons.home, title: "Home"),
  ];
}
