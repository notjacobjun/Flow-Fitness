import 'package:flutter/material.dart';
import 'package:interactive_workout_app/models/workout_category.dart';
import 'package:interactive_workout_app/state_management_helpers/rest_screen_arguments.dart';
import 'package:interactive_workout_app/widgets/transition_timer.dart';
import 'package:provider/provider.dart';

class RestScreen extends StatefulWidget {
  static const routeName = '/rest-screen';

  @override
  _RestScreenState createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  final transitionTime = 30;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as RestScreenArguments;
    final nextWorkoutIndex = args.previousWorkoutIndex;
    final currentWorkoutCategory =
        Provider.of<WorkoutCategory>(context, listen: false)
            .findCategory(args.currentWorkoutCategoryTitle);
    final nextWorkout =
        currentWorkoutCategory.workouts.elementAt(nextWorkoutIndex);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Next workout: ${nextWorkout.title}"),
              Image.network(nextWorkout.imageUrl),
              TransitionTimer(transitionTime, nextWorkoutIndex,
                  args.currentWorkoutCategoryTitle),
            ],
          ),
        ),
      ),
    );
  }
}
