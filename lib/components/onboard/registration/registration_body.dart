import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interactive_workout_app/components/onboard/registration/registration_background.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/home_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/login_screen.dart';
import 'package:interactive_workout_app/services/authentication_service.dart';
import 'package:interactive_workout_app/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

import '../alternate_onboard_option.dart';

class RegistrationBody extends StatefulWidget {
  @override
  _RegistrationBodyState createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  final _formKey = GlobalKey<FormState>();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  var hidePassword = true;
  var hideConfirmPassword = true;
  AuthenticationService authenticationService;
  String email, name, password, confirmPassword;
  StreamSubscription<User> _listener;

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
  }

  void checkUserStatus() {
    _listener = FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You already have an account")));
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  Future<void> register() async {
    if (_formKey.currentState.validate()) {
      _saveForm();
      await authenticationService.signUp(
          name: name, email: email, password: password);
      checkUserStatus();
    }
  }

  @override
  void dispose() {
    if (_listener != null) {
      _listener.cancel();
    }
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return RegistrationBackground(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Flow Fitness",
              style: TextStyle(
                  fontSize: 24, color: Theme.of(context).indicatorColor),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedInputField(
              color: Colors.white,
              child: TextFormField(
                cursorColor: Theme.of(context).accentColor,
                style: TextStyle(color: Theme.of(context).accentColor),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_userNameFocusNode);
                },
                onSaved: (input) => email = input,
                textInputAction: TextInputAction.next,
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
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).accentColor,
                  ),
                  hintText: "Enter your email*",
                ),
              ),
            ),
            RoundedInputField(
              color: Colors.white,
              child: TextFormField(
                focusNode: _userNameFocusNode,
                style: TextStyle(color: Theme.of(context).accentColor),
                cursorColor: Theme.of(context).accentColor,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                onSaved: (input) => name = input,
                textInputAction: TextInputAction.next,
                validator: (input) {
                  if (input == null) {
                    return "Please enter a username";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).accentColor,
                  ),
                  hintText: "Enter a username*",
                ),
              ),
            ),
            RoundedInputField(
              color: Colors.white,
              child: TextFormField(
                focusNode: _passwordFocusNode,
                style: TextStyle(color: Theme.of(context).accentColor),
                onFieldSubmitted: (_) => FocusScope.of(context)
                    .requestFocus(_confirmPasswordFocusNode),
                // onSaved: (input) => password = input,
                onChanged: (input) => password = input,
                textInputAction: TextInputAction.next,
                cursorColor: Theme.of(context).accentColor,
                validator: (input) {
                  if (input.isEmpty) {
                    return "Please enter a password";
                  } else if (input.length < 6) {
                    return "Please enter a stronger password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Theme.of(context).accentColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  hintText: "Enter your password*",
                ),
                obscureText: hidePassword,
              ),
            ),
            RoundedInputField(
              color: Colors.white,
              child: TextFormField(
                focusNode: _confirmPasswordFocusNode,
                style: TextStyle(color: Theme.of(context).accentColor),
                onSaved: (input) => confirmPassword = input,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  register();
                },
                // makes it so that we save the fields once the editing is done
                onEditingComplete: () {
                  setState(() {});
                },
                cursorColor: Theme.of(context).accentColor,
                validator: (input) {
                  if (input != password) {
                    return "The passwords you entered do not match";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.keyboard,
                    color: Theme.of(context).accentColor,
                  ),
                  hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  hintText: "Confirm your password*",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      setState(() {
                        hideConfirmPassword = !hideConfirmPassword;
                      });
                    },
                  ),
                ),
                obscureText: hideConfirmPassword,
              ),
            ),
            RoundedButton(
              message: "Register",
              color: Colors.black,
              function: register,
            ),
            AlternateOnBoardOption(
              size: size,
              message: "Already have an account?",
              buttonContent: "Login",
              nextScreen: LoginScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }
}
