import 'package:flutter/material.dart';
import 'package:interactive_workout_app/screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ab Workout App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.black,
      ),
      routes: {
        '/': (ctx) => CategoriesScreen(),
      },
    );
  }
}
