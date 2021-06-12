import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';
import 'package:interactive_workout_app/state_management_helpers/results_screen_arguments.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results';

  void showHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var calorieSum;
    final args =
        ModalRoute.of(context).settings.arguments as ResultsScreenArguments;
    final currentWorkoutCategory = args.currentWorkoutCategory;
    final totalWorkoutTime = args.totalWorkoutTime;
    // convert the calories into a 2 precision double
    calorieSum = args.totalCaloriesBurned;
    calorieSum = num.parse(calorieSum.toStringAsPrecision(2));
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                "You exercised for $totalWorkoutTime seconds and burned: $calorieSum calories!"),
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
