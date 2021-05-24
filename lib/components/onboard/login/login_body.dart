import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/Welcome/rounded_button.dart';
import 'package:interactive_workout_app/components/onboard/alternate_onboard_option.dart';
import 'package:interactive_workout_app/components/onboard/login/login_background.dart';
import 'package:interactive_workout_app/screens/registration_screen.dart';
import 'package:interactive_workout_app/widgets/RoundedInputField.dart';

class LoginBody extends StatelessWidget {
  bool checkIfLoginValid(String username, String password) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flow Fitness",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  hintText: "Username*",
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
                  hintText: "Password*",
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundedButton(
              message: "Login",
              color: Theme.of(context).primaryColor,
              // TODO implement registration here
            ),
            AlternateOnBoardOption(
              size: size,
              message: "Don't have an account yet?",
              buttonContent: 'Sign up',
              nextScreen: RegistrationScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }
}
