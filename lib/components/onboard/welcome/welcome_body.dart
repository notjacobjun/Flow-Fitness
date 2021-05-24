import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/Welcome/welcome_background.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/screens/login_screen.dart';
import 'package:interactive_workout_app/screens/registration_screen.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomeBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to interactive workout app",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            RoundedButton(
              message: "Login",
              function: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              color: Theme.of(context).primaryColor,
            ),
            RoundedButton(
              message: "Register",
              function: () {
                Navigator.of(context).pushNamed(RegistrationScreen.routeName);
              },
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}