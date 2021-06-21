import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/login/login_body.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: LoginBody(),
    );
  }
}
