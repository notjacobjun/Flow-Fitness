import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_workout_app/providers/workout_category.dart';
import 'package:interactive_workout_app/screens/rest_screen.dart';
import 'package:interactive_workout_app/screens/results_screen.dart';
import 'package:interactive_workout_app/state_management_helpers/rest_screen_arguments.dart';
import 'package:interactive_workout_app/state_management_helpers/results_screen_arguments.dart';

class WorkoutTimer extends StatefulWidget {
  final int workoutDuration;
  final int prepDuration;
  var currentWorkoutIndex;
  final String currentWorkoutCategoryTitle;
  final InnerWorkoutCategoryItem currentWorkoutCategory;
  var totalWorkoutTime;
  var totalCaloriesBurned;

  WorkoutTimer(
    this.workoutDuration,
    this.prepDuration,
    this.currentWorkoutIndex,
    this.currentWorkoutCategoryTitle,
    this.currentWorkoutCategory,
    this.totalWorkoutTime,
    this.totalCaloriesBurned,
  );

  @override
  _WorkoutTimerState createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  var prevDisabled;
  var nextDisabled;
  var workoutPaused = false;
  var prepPaused = false;
  var isPrepTime = true;
  var _workoutTime;
  var totalCaloriesBurned;
  var _prepTime;
  var totalTime;
  Duration prepDuration;
  Duration workoutDuration;
  Timer _workoutTimer;
  Timer _prepTimer;

  @override
  void initState() {
    _workoutTime = widget.workoutDuration;
    _prepTime = widget.prepDuration;
    workoutDuration = Duration(seconds: widget.workoutDuration);
    prepDuration = Duration(seconds: widget.prepDuration);
    totalTime = widget.totalWorkoutTime;
    totalCaloriesBurned = widget.totalCaloriesBurned;
    startPrepTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_workoutTimer != null) {
      _workoutTimer.cancel();
    }
    if (_prepTimer != null) {
      _prepTimer.cancel();
    }
    super.dispose();
  }

  void pauseWorkoutTimer() {
    if (_workoutTimer != null) {
      setState(() {
        workoutPaused = !workoutPaused;
        _workoutTimer.cancel();
      });
    }
  }

  void unpauseWorkoutTimer() {
    setState(() {
      workoutPaused = !workoutPaused;
      startWorkoutTimer();
    });
  }

  void pausePrepTimer() {
    if (_prepTimer != null) {
      setState(() {
        prepPaused = !prepPaused;
        _prepTimer.cancel();
      });
    }
  }

  void unpausePrepTimer() {
    setState(() {
      prepPaused = !prepPaused;
      startPrepTimer();
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void startPrepTimer() {
    const oneSec = const Duration(seconds: 1);
    _prepTimer = new Timer.periodic(oneSec, (timer) {
      if (_prepTime == 0) {
        setState(() {
          timer.cancel();
          isPrepTime = false;
          startWorkoutTimer();
        });
      } else {
        setState(() {
          _prepTime--;
          prepDuration = Duration(seconds: _prepTime);
        });
      }
    });
  }

  void startWorkoutTimer() {
    const oneSec = const Duration(seconds: 1);
    _workoutTimer = new Timer.periodic(oneSec, (timer) {
      if (_workoutTime == 0) {
        setState(() {
          timer.cancel();
          handleTimeout();
        });
      } else {
        setState(() {
          totalTime++;
          totalCaloriesBurned += (widget.currentWorkoutCategory.workouts
                  .elementAt(widget.currentWorkoutIndex)
                  .caloriesPerMinute) /
              60;
          _workoutTime--;
          workoutDuration = Duration(seconds: _workoutTime);
          print(totalCaloriesBurned);
        });
      }
    });
  }

  void handleTimeout() {
    if (widget.currentWorkoutIndex >=
        widget.currentWorkoutCategory.workouts.length - 1) {
      Navigator.pushReplacementNamed(
        context,
        ResultsScreen.routeName,
        arguments: ResultsScreenArguments(
            currentWorkoutCategory: widget.currentWorkoutCategory,
            totalWorkoutTime: widget.totalWorkoutTime,
            totalCaloriesBurned: totalCaloriesBurned),
      );
    } else {
      Navigator.of(context).pushReplacementNamed(RestScreen.routeName,
          arguments: RestScreenArguments(
              previousWorkoutIndex: widget.currentWorkoutIndex + 1,
              currentWorkoutCategoryTitle: widget.currentWorkoutCategoryTitle,
              totalWorkoutTime: totalTime,
              totalCaloriesBurned: totalCaloriesBurned));
    }
  }

  @override
  Widget build(BuildContext context) {
    prevDisabled = widget.currentWorkoutIndex == 0;
    nextDisabled = widget.currentWorkoutIndex ==
        widget.currentWorkoutCategory.workouts.length - 1;
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          PrevPauseForwardButtons(context),
          isPrepTime
              ? Text(
                  "Get Ready!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              : Text(
                  "Go!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
          CircleAvatar(
            child: isPrepTime
                ? Text(
                    prepDuration == null
                        ? "no time entered"
                        : _printDuration(prepDuration),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).indicatorColor,
                    ),
                  )
                : Text(
                    workoutDuration == null
                        ? "no time entered"
                        : _printDuration(workoutDuration),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
            backgroundColor: Theme.of(context).primaryColor,
            maxRadius: size.height * 0.07,
          ),
        ]),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row PrevPauseForwardButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipOval(
          child: Material(
            color: prevDisabled
                ? Colors.grey
                : Theme.of(context).primaryColor, // Button color
            child: InkWell(
              splashColor: Colors.black26, // Splash color
              onTap: () {
                prevDisabled
                    ? null
                    : setState(() {
                        widget.currentWorkoutIndex -= 2;
                        handleTimeout();
                      });
              },
              child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).indicatorColor,
                  )),
            ),
          ),
        ),
        ClipOval(
          child: Material(
            color: Theme.of(context).primaryColor, // Button color
            child: InkWell(
              splashColor: Colors.black26, // Splash color
              onTap: () {
                if (isPrepTime) {
                  if (!prepPaused) {
                    pausePrepTimer();
                  } else {
                    unpausePrepTimer();
                  }
                } else {
                  if (!workoutPaused) {
                    pauseWorkoutTimer();
                  } else {
                    unpauseWorkoutTimer();
                  }
                }
              },
              child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    isPrepTime
                        ? prepPaused
                            ? Icons.play_arrow
                            : Icons.pause
                        : workoutPaused
                            ? Icons.play_arrow
                            : Icons.pause,
                    color: Theme.of(context).indicatorColor,
                  )),
            ),
          ),
        ),
        ClipOval(
          child: Material(
            color: Theme.of(context).primaryColor, // Button color
            child: InkWell(
              splashColor: Colors.black26, // Splash color
              onTap: () {
                // TODO exit the workout
                // nextDisabled
                //     ? print("Exit the workout and show results page")
                handleTimeout();
              },
              child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).indicatorColor,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
