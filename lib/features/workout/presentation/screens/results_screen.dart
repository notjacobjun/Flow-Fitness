import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/home_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/provider/workout_category.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:interactive_workout_app/state_management_helpers/results_screen_arguments.dart';
import 'package:interactive_workout_app/widgets/rounded_app_bar.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  static const routeName = '/results';

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  void showHomeScreen(
      BuildContext context, InnerWorkoutCategoryItem currentWorkoutCategory) {
    Provider.of<WorkoutCategory>(context, listen: false)
        .resetWorkoutTimes(currentWorkoutCategory);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  var calorieSum;
  int totalWorkoutTime;
  InnerWorkoutCategoryItem currentWorkoutCategory;
  FitnessUpdate currentFitnessUpdate;
  String currentWorkoutCategoryTitle;
  final DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var calorieSum;
    final args =
        ModalRoute.of(context).settings.arguments as ResultsScreenArguments;
    final currentWorkoutCategory = args.currentWorkoutCategory;
    final totalWorkoutTime = args.totalWorkoutTime / 60;
    calorieSum = args.totalCaloriesBurned;
    calorieSum = num.parse(calorieSum.toStringAsFixed(2)).toDouble();
    return Scaffold(
      appBar: RoundedAppBar(
        text: Text("Results"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("You exercised for " +
                totalWorkoutTime.toStringAsFixed(1) +
                " minutes and burned: $calorieSum calories!"),
            RoundedButton(
              message: "Finish",
              color: Theme.of(context).primaryColor,
              function: () {
                UserService().updateUsersDB(calorieSum, totalWorkoutTime);
                showHomeScreen(context, currentWorkoutCategory);
              },
            ),
          ],
        ),
      ),
    );
  }
}
