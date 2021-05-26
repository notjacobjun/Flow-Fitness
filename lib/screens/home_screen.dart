import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/services/authentication_service.dart';

import 'categories_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
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
            CategoriesScreen(),
            RoundedButton(
              message: "Sign out",
              color: Theme.of(context).accentColor,
              function: (context) {
                context.read<AuthenticationService>().signOut();
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
