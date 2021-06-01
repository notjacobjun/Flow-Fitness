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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Workouts",
        ),
      ),
      drawer: DetailDrawer(context),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      body: GridView(
        padding: EdgeInsets.all(20),
        children: WORKOUT_CATEGORIES
            .map(
              (workout) => WorkoutItem(
                title: workout.title,
                category: workout.category,
                color: workout.color,
                image: workout.image,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 400,
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}
