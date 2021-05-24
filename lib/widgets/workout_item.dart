import 'package:flutter/material.dart';
import 'package:interactive_workout_app/models/workout.dart';

class WorkoutItem extends StatelessWidget {
  final String title;
  final Category category;
  final Color color;

  WorkoutItem({this.title, this.category, this.color});

// TODO configure this
  void selectWorkout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    print(this.color.toString());
    return Card(
      child: InkWell(
        onTap: () => selectWorkout(context),
        child: Row(
          children: [
            // CircleAvatar(
            //   radius: 30,
            //   backgroundColor: Theme.of(context).primaryColor,
            //   child: Text(
            //     title,
            //     style: TextStyle(fontSize: 14),
            //   ),
            // ),
            SafeArea(
              child: Column(
                children: [
                  Text(title),
                  Text("Enter description here"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
