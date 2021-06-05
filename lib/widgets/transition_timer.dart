import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_workout_app/screens/workout_screen.dart';
import 'package:interactive_workout_app/state_management_helpers/workout_screen_arguments.dart';

class TransitionTimer extends StatefulWidget {
  final int transitionDuration;
  final int nextWorkoutIndex;
  final String workoutCategoryTitle;

  TransitionTimer(this.transitionDuration, this.nextWorkoutIndex,
      this.workoutCategoryTitle);

  @override
  _TransitionTimerState createState() => _TransitionTimerState();
}

class _TransitionTimerState extends State<TransitionTimer> {
  int _transitionTime;
  Duration transitionDuration;
  Timer _transitionTimer;

  @override
  void initState() {
    _transitionTime = widget.transitionDuration;
    transitionDuration = Duration(seconds: widget.transitionDuration);
    startTransitionTimer();
    super.initState();
  }

  @override
  void dispose() {
    _transitionTimer.cancel();
    super.dispose();
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void startTransitionTimer() {
    const oneSec = const Duration(seconds: 1);
    _transitionTimer = new Timer.periodic(oneSec, (timer) {
      if (_transitionTime == 0) {
        setState(() {
          timer.cancel();
          handleTimeout();
        });
      } else {
        setState(() {
          _transitionTime--;
          transitionDuration = Duration(seconds: _transitionTime);
        });
      }
    });
  }

  void handleTimeout() {
    Navigator.pushReplacementNamed(context, WorkoutScreen.routeName,
        arguments: WorkoutScreenArguments(
            currentWorkoutCategoryTitle: widget.workoutCategoryTitle,
            upcomingWorkoutIndex: widget.nextWorkoutIndex));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Rest up!"),
          CircleAvatar(
            child: Text(
              transitionDuration == null
                  ? "no time entered"
                  : _printDuration(transitionDuration),
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
