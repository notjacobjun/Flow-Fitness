import 'package:flutter/material.dart';
import 'package:interactive_workout_app/screens/categories_screen.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';
import 'package:interactive_workout_app/screens/login_screen.dart';
import 'package:interactive_workout_app/screens/registration_screen.dart';
import 'package:interactive_workout_app/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Workout App',
      theme: ThemeData(
        primaryColor: Colors.orange.shade900,
        accentColor: Colors.black,
        fontFamily: "Quicksand",
      ),
      routes: {
        '/': (ctx) => WelcomeScreen(),
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
      },
    );
  }
}
