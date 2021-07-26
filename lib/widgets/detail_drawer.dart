import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/login_screen.dart';

class DetailDrawer extends StatelessWidget {
  final BuildContext context;

  DetailDrawer(this.context);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          DrawerHeader(
            child: Text(
              "Configuration",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          RoundedButton(
            message: "Sign out",
            color: Theme.of(context).accentColor,
            function: signOut,
          ),
        ],
      ),
    );
  }
}
