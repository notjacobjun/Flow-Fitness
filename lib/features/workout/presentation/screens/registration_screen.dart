import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/registration/registration_body.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/registration';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade600, Colors.blue.shade900],
            ),
          ),
        ),
      ),
      body: RegistrationBody(),
    );
  }
}
