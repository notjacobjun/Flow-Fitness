import 'package:flutter/material.dart';
import 'package:interactive_workout_app/models/workout.dart';
import 'package:interactive_workout_app/models/workout_category.dart';
import 'package:interactive_workout_app/widgets/workout_timer.dart';
import 'package:provider/provider.dart';

class WorkoutScreen extends StatefulWidget {
  static const routeName = "/workout-screen";

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  Future<Widget> showWorkout(Workout workout) {
    Duration duration = Duration(seconds: workout.workoutDuration);
    if (workout.difficulty == Difficulty.Easy) {
      duration = Duration(seconds: workout.workoutDuration - 10);
    } else if (workout.difficulty == Difficulty.Hard) {
      duration = Duration(seconds: workout.workoutDuration + 10);
    } else if (workout.difficulty == Difficulty.Impossible) {
      duration = Duration(seconds: workout.workoutDuration + 20);
    }
    // turn this into a future
    // return WorkoutTimer(duration);
    // Timer.periodic(duration, (timer) {});
  }

  void showRestScreen(Workout upcomingWorkout) {}

  @override
  Widget build(BuildContext context) {
    const prepDuration = 5;
    Size size = MediaQuery.of(context).size;
    var index = 0;
    final workoutTitle = ModalRoute.of(context).settings.arguments as String;
    final currentWorkoutCategory =
        Provider.of<WorkoutCategory>(context, listen: false)
            .categories
            .singleWhere(
                (workoutCategory) => workoutCategory.title == workoutTitle);
    final currentWorkout = currentWorkoutCategory.workouts.elementAt(index);
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(workoutTitle),
        backwardsCompatibility: true,
      ),
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              currentWorkout.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Image.network(currentWorkout.imageUrl),
            WorkoutTimer(currentWorkout.workoutDuration, prepDuration),
            // TODO enter an animation of someone working out here, then put the timer below it with the buttons to stop the timer and also skip or prev.
          ],
        ),
      ),
    );
  }
}
