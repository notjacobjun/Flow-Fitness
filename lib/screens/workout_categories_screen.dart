import 'package:flutter/material.dart';
import 'package:interactive_workout_app/providers/workout_category.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_app_bar.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';
import 'package:interactive_workout_app/widgets/workout_category_item.dart';
import 'package:provider/provider.dart';

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
    final List<InnerWorkoutCategoryItem> workoutcategories =
        Provider.of<WorkoutCategory>(context).categories;
    return Scaffold(
      appBar: RoundedAppBar(text: Text("Workouts")),
      drawer: DetailDrawer(context),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      body: GridView(
        padding: EdgeInsets.all(20),
        children: workoutcategories
            .map(
              (workout) => WorkoutCategoryItem(
                title: workout.title,
                description: workout.description,
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
