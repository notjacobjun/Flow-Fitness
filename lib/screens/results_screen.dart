import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/models/workout_category.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results';

  void showHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double calorieSum = 0;
    final args =
        ModalRoute.of(context).settings.arguments as InnerWorkoutCategoryItem;
    args.workouts.forEach((workout) {
      calorieSum += (workout.caloriesPerMinute * 2);
    });
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                "Congratulations on completing the ${args.title}. You burned: ${calorieSum} calories!"),
            RoundedButton(
              message: "Finish",
              color: Theme.of(context).primaryColor,
              function: () {
                showHomeScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
