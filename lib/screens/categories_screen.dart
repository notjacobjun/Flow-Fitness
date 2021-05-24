import 'package:flutter/material.dart';
import 'package:interactive_workout_app/widgets/workout_item.dart';

import '../workout_data.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/category-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout central"),
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
