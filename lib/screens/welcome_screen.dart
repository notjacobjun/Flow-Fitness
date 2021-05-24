import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/welcome_body.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive workout app"),
      ),
      body: WelcomeBody(),
    );
  }
}
