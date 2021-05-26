import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/Welcome/rounded_button.dart';
import 'package:interactive_workout_app/components/onboard/alternate_onboard_option.dart';
import 'package:interactive_workout_app/components/onboard/login/login_background.dart';
import 'package:interactive_workout_app/screens/registration_screen.dart';
import 'package:interactive_workout_app/services/authentication_service.dart';
import 'package:interactive_workout_app/widgets/RoundedInputField.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  LoginBody({Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  AuthenticationService authenticationService;

  bool checkIfLoginValid(String username, String password) {
    return false;
  }

// configure the formKey
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkUserStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    Size size = MediaQuery.of(context).size;
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
                controller: userController,
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
                controller: passwordController,
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
              function: () {
                authenticationService.signIn(
                    email: userController.text,
                    password: passwordController.text);
                checkUserStatus();
              },
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
