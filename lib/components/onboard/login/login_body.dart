import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/Welcome/rounded_button.dart';
import 'package:interactive_workout_app/components/onboard/alternate_onboard_option.dart';
import 'package:interactive_workout_app/components/onboard/login/login_background.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';
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
// configure the formKey
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  bool checkIfLoginValid(String username, String password) {
    return false;
  }

// TODO dispose of this listener once the state of this class is inactive
// (not using login page anymore)
  void checkUserStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  void login() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      // save the form items into the fields then use the fields for validation
      formState.save();
      // TODO consider adding progress bar for this, because it could be a slow
      // operation depending on network speed I think (not 100% sure)
      authenticationService.signIn(email: _email, password: _password);
      checkUserStatus();
    }
  }

  @override
  void dispose() {
    // TODO dispose of the listener above
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flow Fitness",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              RoundedInputField(
                child: TextFormField(
                  cursorColor: Theme.of(context).accentColor,
                  // ignore: missing_return
                  validator: (input) {
                    // checks the email input according to HTML 5 email
                    // validation specifications
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(input);
                    if (!emailValid) {
                      return "Please enter a valid email";
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).accentColor,
                    ),
                    hintText: "Email*",
                  ),
                ),
              ),
              RoundedInputField(
                child: TextFormField(
                  cursorColor: Theme.of(context).accentColor,
                  // ignore: missing_return
                  validator: (input) {
                    if (input.length < 6) {
                      return "Please provide a stronger password (at least 6 characters)";
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.password,
                      color: Theme.of(context).accentColor,
                    ),
                    hintText: "Password*",
                    suffixIcon: Icon(Icons.visibility),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RoundedButton(
                message: "Login",
                color: Theme.of(context).primaryColor,
                function: login,
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
      ),
    );
  }
}
