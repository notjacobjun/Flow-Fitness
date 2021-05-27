import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  final BuildContext context;

  HomeScreen(this.context);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flow Fitness"),
      ),
      drawer: Drawer(
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
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
