import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/Welcome/rounded_button.dart';
import 'package:interactive_workout_app/components/onboard/alternate_onboard_option.dart';
import 'package:interactive_workout_app/components/onboard/login/login_background.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';
import 'package:interactive_workout_app/screens/registration_screen.dart';
import 'package:interactive_workout_app/services/authentication_service.dart';
import 'package:interactive_workout_app/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  LoginBody({Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  StreamSubscription<User> _listener;
  AuthenticationService authenticationService;
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  var hideText = true;
  String _email, _password;

  void checkUserStatus() {
    _listener = FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid login info'),
          ),
        );
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  Future<void> login() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      // save the form items into the fields then use the fields for validation
      formState.save();
      await authenticationService.signIn(email: _email, password: _password);
      checkUserStatus();
    }
  }

  @override
  void dispose() {
    if (_listener != null) {
      _listener.cancel();
    }
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
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
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
                    return null;
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
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: login,
                  // ignore: missing_return
                  validator: (input) {
                    return input.isEmpty ? "Please enter your password" : null;
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.password,
                      color: Theme.of(context).accentColor,
                    ),
                    hintText: "Password*",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          hideText = !hideText;
                        });
                      },
                    ),
                  ),
                  obscureText: hideText,
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
