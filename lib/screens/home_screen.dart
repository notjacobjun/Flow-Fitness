import 'package:flutter/material.dart';

import 'categories_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ab-workouts"),
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
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
