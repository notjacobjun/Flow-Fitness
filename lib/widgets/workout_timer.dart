import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_workout_app/screens/rest_screen.dart';
import 'package:interactive_workout_app/state_management_helpers/rest_screen_arguments.dart';

class WorkoutTimer extends StatefulWidget {
  final int workoutDuration;
  final int prepDuration;
  final int currentWorkoutIndex;
  final String currentWorkoutTitle;

  WorkoutTimer(this.workoutDuration, this.prepDuration,
      this.currentWorkoutIndex, this.currentWorkoutTitle);

  @override
  _WorkoutTimerState createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  var isPrepTime = true;
  int _workoutTime;
  int _prepTime;
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
    startPrepTimer();
    super.initState();
  }

  @override
  void dispose() {
    _workoutTimer.cancel();
    _prepTimer.cancel();
    super.dispose();
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
          _workoutTime--;
          workoutDuration = Duration(seconds: _workoutTime);
        });
      }
    });
  }

  void handleTimeout() {
    // stop the timer and start the rest timer, unless there are no more workouts in queue
    Navigator.of(context).pushReplacementNamed(RestScreen.routeName,
        arguments: RestScreenArguments(
            previousWorkoutIndex: widget.currentWorkoutIndex,
            currentWorkoutCategoryTitle: widget.currentWorkoutTitle));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      color: Colors.white,
                    ),
                  )
                : Text(
                    workoutDuration == null
                        ? "no time entered"
                        : _printDuration(workoutDuration),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
            backgroundColor: Theme.of(context).primaryColor,
            maxRadius: size.height * 0.07,
          ),
        ]),
      ),
    );
  }
}
