import 'package:flutter/material.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';
import 'package:interactive_workout_app/widgets/workout_item.dart';

import '../workout_data.dart';

class WorkoutCategoriesScreen extends StatefulWidget {
  static const routeName = '/category-screen';

  @override
  _WorkoutCategoriesScreenState createState() =>
      _WorkoutCategoriesScreenState();
}

class _WorkoutCategoriesScreenState extends State<WorkoutCategoriesScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workouts"),
      ),
      drawer: DetailDrawer(context),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      body: GridView(
        padding: EdgeInsets.all(20),
        // TODO consider replacing with data from DB instead
        children: WORKOUT_CATEGORIES
            .map(
              (workout) => WorkoutItem(
                  title: workout.title,
                  category: workout.category,
                  color: workout.color),
            )
            .toList(),
        // TODO consider making more responsive
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
