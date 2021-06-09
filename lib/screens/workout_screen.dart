import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/providers/workout_category.dart';
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
    final totalWorkoutTime = args == null ? 0 : args.totalWorkoutTime;
    final totalCaloriesBurned = args.totalCaloriesBurned;
    print(totalWorkoutTime);
    print(totalCaloriesBurned);
    const prepDuration = 5;
    Size size = MediaQuery.of(context).size;
    final currentWorkoutCategory = args.currentWorkoutCategory;
    final currentWorkout =
        currentWorkoutCategory.workouts.elementAt(upcomingWorkoutIndex);

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(workoutTitle),
        leading: IconButton(
          icon: Icon(Theme.of(context).platform == TargetPlatform.iOS
              ? Icons.arrow_back_ios
              : Icons.arrow_back),
          onPressed: () async {
            if (await confirm(
              context,
              title: Text('Confirm'),
              content: Text('Would you like to remove?'),
              textOK: Text('Yes'),
              textCancel: Text('No'),
            )) {
              Provider.of<WorkoutCategory>(context, listen: false)
                  .resetWorkoutTimes(currentWorkoutCategory);
              return Navigator.of(context).pop();
            }
            return print('pressedCancel');
            // final choice = showDialog(
            //   context: context,
            //   builder: (_) => CustomDialogBox(
            //     title: "Confirm",
            //     descriptions:
            //         "Are you sure that you want to exit this workout early",
            //     positiveText: "Yes",
            //     negativeText: "No",
            //   ),
            // );
            // if (choice) {
            // }

            // Navigator.of(context).pop();
            // var isPop;
            // isPop = showOkCancelAlertDialog(
            //     context: context,
            //     title: "Confirm",
            //     okLabel: "Exit",
            //     useRootNavigator: true,
            //     cancelLabel: "Stay",
            //     onWillPop: () {
            //       isPop = OkCancelResult.cancel;
            //       return Future.value(false);
            //     },
            //     message:
            //         "Are you sure that you want to exit already? (You won't get any rewards)");
            // print(isPop);
            // if (isPop == OkCancelResult.cancel) {
            //   Provider.of<WorkoutCategory>(context)
            //       .resetWorkoutTimes(currentWorkoutCategory);
            //   Navigator.of(context).pop();
            // }
          },
        ),
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
          WorkoutTimer(
              currentWorkout.workoutDuration,
              prepDuration,
              upcomingWorkoutIndex,
              workoutTitle,
              currentWorkoutCategory,
              totalWorkoutTime,
              totalCaloriesBurned)
          // PrevPauseForwardButtons(upcomingWorkoutIndex),
        ]),
      ),
    );
  }
}
