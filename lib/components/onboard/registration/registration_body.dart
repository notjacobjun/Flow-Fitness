import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/registration/registration_background.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/screens/login_screen.dart';
import 'package:interactive_workout_app/widgets/RoundedInputField.dart';

import '../alternate_onboard_option.dart';

class RegistrationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return RegistrationBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Flow Fitness",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          RoundedInputField(
            child: TextField(
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).accentColor,
                ),
                hintText: "Enter a username*",
              ),
            ),
          ),
          RoundedInputField(
            child: TextField(
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.password,
                  color: Theme.of(context).accentColor,
                ),
                suffixIcon: Icon(Icons.visibility),
                hintText: "Enter your password*",
              ),
            ),
          ),
          RoundedInputField(
            child: TextField(
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.keyboard,
                  color: Theme.of(context).accentColor,
                ),
                hintText: "Confirm your password*",
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
          ),
          RoundedButton(
            message: "Register",
            color: Theme.of(context).primaryColor,
            // TODO implement registration here
          ),
          AlternateOnBoardOption(
            size: size,
            message: "Already have an account?",
            buttonContent: "Login",
            nextScreen: LoginScreen.routeName,
          ),
        ],
      ),
    );
  }
}
