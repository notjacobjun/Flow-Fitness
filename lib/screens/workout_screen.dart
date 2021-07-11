import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
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
  var backPressed = false;
  final AudioCache cache = new AudioCache();

  Future<AudioPlayer> playAlertSound() async {
    await cache.play("sounds/alert.mp3");
  }

  Future<void> showAdaptiveDialog(
      BuildContext context, InnerWorkoutCategoryItem currentWorkoutCategory) {
    var isiOS = (Theme.of(context).platform == TargetPlatform.iOS);
    playAlertSound();
    if (isiOS) {
      return showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text("Confirmation"),
          content: Text(
              "Are you sure that you want to exit this workout early? (Your burned calories won't be recorded)"),
          actions: [
            CupertinoDialogAction(
              child: Text("Yes", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Provider.of<WorkoutCategory>(context, listen: false)
                    .resetWorkoutTimes(currentWorkoutCategory);
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("No"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Confirmation"),
          content: Text(
              "Are you sure that you want to exit this workout early? (Your burned calories won't be recorded)"),
          actions: [
            TextButton(
              child: Text("Yes", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Provider.of<WorkoutCategory>(context, listen: false)
                    .resetWorkoutTimes(currentWorkoutCategory);
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(workoutTitle),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFff9966), Color(0xFFff5e62)],
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.arrow_back_ios
                : Icons.arrow_back),
            onPressed: () async {
              showAdaptiveDialog(context, currentWorkoutCategory);
              // if (await confirm(
              //   context,
              //   title: Text('Confirm'),
              //   content: Text(
              //       'Are you sure that you want to leave this workout early? (you won\'t gain any rewards)'),
              //   textOK: Text('Yes'),
              //   textCancel: Text('No'),
              // )) {
              //   Provider.of<WorkoutCategory>(context, listen: false)
              //       .resetWorkoutTimes(currentWorkoutCategory);
              //   return Navigator.of(context).pop();
              // }
              // return print('pressedCancel');
            },
          ),
        ),
        body: Container(
          width: size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  currentWorkout.title,
                  style: TextStyle(fontSize: 18),
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
      ),
    );
  }
}
