import 'package:flutter/material.dart';
import 'package:interactive_workout_app/models/workout_category.dart';
import 'package:interactive_workout_app/state_management_helpers/workout_screen_arguments.dart';
import 'package:interactive_workout_app/widgets/workout_timer.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  static const routeName = "/workout-screen";
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  // Widget showWorkout(Workout workout) {
  //   Duration duration = Duration(seconds: workout.workoutDuration);
  //   if (workout.difficulty == Difficulty.Easy) {
  //     duration = Duration(seconds: workout.workoutDuration - 10);
  //   } else if (workout.difficulty == Difficulty.Hard) {
  //     duration = Duration(seconds: workout.workoutDuration + 10);
  //   } else if (workout.difficulty == Difficulty.Impossible) {
  //     duration = Duration(seconds: workout.workoutDuration + 20);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as WorkoutScreenArguments;
    final workoutTitle = args.currentWorkoutCategoryTitle;
    var upcomingWorkoutIndex = args.upcomingWorkoutIndex;
    const prepDuration = 5;
    Size size = MediaQuery.of(context).size;
    final currentWorkoutCategory = Provider.of<WorkoutCategory>(context,
            listen: false)
        .categories
        .firstWhere((workoutCategory) => workoutCategory.title == workoutTitle);
    final currentWorkout =
        currentWorkoutCategory.workouts.elementAt(upcomingWorkoutIndex);

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(workoutTitle),
        backwardsCompatibility: true,
      ),
      body: Container(
        width: size.width,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            currentWorkout.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Image.network(currentWorkout.imageUrl),
          WorkoutTimer(currentWorkout.workoutDuration, prepDuration,
              upcomingWorkoutIndex, workoutTitle),
          // PrevPauseForwardButtons(upcomingWorkoutIndex),
        ]),
      ),
    );
  }
}
