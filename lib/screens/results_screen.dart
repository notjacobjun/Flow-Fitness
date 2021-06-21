import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/providers/workout_category.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:interactive_workout_app/state_management_helpers/results_screen_arguments.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results';

  void showHomeScreen(
      BuildContext context, InnerWorkoutCategoryItem currentWorkoutCategory) {
    Provider.of<WorkoutCategory>(context, listen: false)
        .resetWorkoutTimes(currentWorkoutCategory);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var calorieSum;
    final args =
        ModalRoute.of(context).settings.arguments as ResultsScreenArguments;
    final currentWorkoutCategory = args.currentWorkoutCategory;
    final totalWorkoutTime = args.totalWorkoutTime;
    calorieSum = args.totalCaloriesBurned;
    calorieSum = num.parse(calorieSum.toStringAsPrecision(2)).toDouble();
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
                UserService().updateUsersDB(calorieSum);
                showHomeScreen(context, currentWorkoutCategory);
              },
            ),
          ],
        ),
      ),
    );
  }
}
