import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/workout_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/provider/workout_category.dart';
import 'package:interactive_workout_app/state_management_helpers/workout_screen_arguments.dart';

class TransitionTimer extends StatefulWidget {
  final int transitionDuration;
  var nextWorkoutIndex;
  final String workoutCategoryTitle;
  final InnerWorkoutCategoryItem currentWorkoutCategory;
  final int totalWorkoutTime;
  final double totalCaloriesBurned;

  TransitionTimer(
      {this.transitionDuration,
      this.nextWorkoutIndex,
      this.workoutCategoryTitle,
      this.currentWorkoutCategory,
      this.totalWorkoutTime,
      this.totalCaloriesBurned});

  @override
  _TransitionTimerState createState() => _TransitionTimerState();
}

class _TransitionTimerState extends State<TransitionTimer> {
  var paused = false;
  int _transitionTime;
  Duration transitionDuration;
  Timer _transitionTimer;
  final AudioCache cache = AudioCache();

  @override
  void initState() {
    _transitionTime = widget.transitionDuration;
    transitionDuration = Duration(seconds: widget.transitionDuration);
    startTransitionTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_transitionTimer != null) {
      _transitionTimer.cancel();
    }
    super.dispose();
  }

  Future<AudioPlayer> playPauseSound() async {
    return cache.play("sounds/pause.mp3");
  }

  Future<AudioPlayer> playStartSound() async {
    return cache.play("sounds/start.mp3");
  }

  void pauseTimer() {
    if (_transitionTimer != null) {
      playPauseSound();
      setState(() {
        paused = !paused;
        _transitionTimer.cancel();
      });
    }
  }

  void unpauseTimer() {
    playStartSound();
    setState(() {
      paused = !paused;
      startTransitionTimer();
    });
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
            currentWorkoutCategory: widget.currentWorkoutCategory,
            upcomingWorkoutIndex: widget.nextWorkoutIndex,
            totalWorkoutTime: widget.totalWorkoutTime,
            totalCaloriesBurned: widget.totalCaloriesBurned));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          PrevPauseForwardButtons(context),
          Text(
            "Rest up!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          CircleAvatar(
            child: Text(
              transitionDuration == null
                  ? "no time entered"
                  : _printDuration(transitionDuration),
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

  Row PrevPauseForwardButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipOval(
          child: Material(
            color: Theme.of(context).primaryColor, // Button color
            child: InkWell(
              splashColor: Colors.black26, // Splash color
              onTap: () {
                setState(() {
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
                if (!paused) {
                  pauseTimer();
                } else {
                  unpauseTimer();
                }
              },
              child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    paused ? Icons.play_arrow : Icons.pause,
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
