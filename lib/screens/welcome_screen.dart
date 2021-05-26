import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/welcome_body.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Flow Fitness"),
      ),
      body: WelcomeBody(),
    );
  }
}
