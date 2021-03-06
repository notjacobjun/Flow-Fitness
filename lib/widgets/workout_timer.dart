import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/core/network/network_info.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/data/repositories/fitness_update_repository_impl.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/save_fitness_update.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/rest_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/screens/results_screen.dart';
import 'package:interactive_workout_app/features/workout/presentation/provider/workout_category.dart';
import 'package:interactive_workout_app/state_management_helpers/rest_screen_arguments.dart';
import 'package:interactive_workout_app/state_management_helpers/results_screen_arguments.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class WorkoutTimer extends StatefulWidget {
  GlobalKey<_WorkoutTimerState> globalKey =
      GlobalKey<_WorkoutTimerState>(debugLabel: 'workoutTimerKey');
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
  AudioCache cache = new AudioCache();
  AudioPlayer countdownTimerAudioPlayer;
  bool playingCountdownSound = false;

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

  Future<AudioPlayer> playCountdownSound() async {
    return await cache.play("sounds/countdown.wav",
        mode: PlayerMode.LOW_LATENCY);
  }

  Future<AudioPlayer> playStartSound() async {
    return cache.play("sounds/start.mp3");
  }

  Future<AudioPlayer> playPauseSound() async {
    return cache.play("sounds/pause.mp3");
  }

  Future<void> pauseWorkoutTimer() async {
    playPauseSound();
    if (_workoutTimer != null) {
      if (playingCountdownSound) {
        if (countdownTimerAudioPlayer != null) {
          int result = await countdownTimerAudioPlayer.pause();
          print("pausing result: $result");
          playingCountdownSound = !playingCountdownSound;
        }
      }
      setState(() {
        workoutPaused = !workoutPaused;
        _workoutTimer.cancel();
      });
    }
  }

  Future<void> unpauseWorkoutTimer() async {
    playStartSound();
    if (!playingCountdownSound) {
      if (countdownTimerAudioPlayer != null) {
        int result = await countdownTimerAudioPlayer.resume();
        print("resume result: $result");
        playingCountdownSound = true;
      }
    }
    setState(() {
      workoutPaused = !workoutPaused;
      startWorkoutTimer();
    });
  }

  void pausePrepTimer() {
    playPauseSound();
    if (_prepTimer != null) {
      setState(() {
        prepPaused = !prepPaused;
        _prepTimer.cancel();
      });
    }
  }

  void unpausePrepTimer() {
    playStartSound();
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
    playStartSound();
    const oneSec = const Duration(seconds: 1);
    _prepTimer = new Timer.periodic(oneSec, (timer) async {
      if (_prepTime == 0) {
        // TODO add condition here to check if the user prefers vibrations off
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 200);
        }
        playStartSound();
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
    _workoutTimer = new Timer.periodic(oneSec, (timer) async {
      if (_workoutTime == 4) {
        playingCountdownSound = true;
        countdownTimerAudioPlayer = await playCountdownSound();
      }
      if (_workoutTime == 0) {
        setState(() {
          timer.cancel();
          handleTimeout();
        });
        playingCountdownSound = false;
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
      // save the currentfitnessupdate
      var totalWorkoutTime = widget.totalWorkoutTime;
      var calorieSum = widget.totalCaloriesBurned;
      calorieSum = num.parse(calorieSum.toStringAsPrecision(2)).toDouble();
      var currentWorkoutCategoryTitle = widget.currentWorkoutCategoryTitle;
      final DateTime date = DateTime.now();
      final currentFitnessUpdate =
          Provider.of<FitnessUpdateModel>(context, listen: false);
      currentFitnessUpdate.updateFitnessUpdateInfo(FitnessUpdateModel(
          caloriesBurned: calorieSum,
          dateTime: date,
          totalWorkoutTime: totalWorkoutTime,
          workoutTitle: currentWorkoutCategoryTitle));
      final saveFitnessUpdateUseCase = SaveFitnessUpdate(
          FitnessUpdateRepositoryImpl(
              networkInfo: NetworkInfoImpl(DataConnectionChecker()),
              remoteDataSource: FitnessUpdateRemoteDataSourceImpl()));
      saveFitnessUpdateUseCase
          .call(Params(fitnessUpdate: currentFitnessUpdate));

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
    // final currentWorkoutCategory = widget.currentWorkoutCategory;
    prevDisabled = widget.currentWorkoutIndex == 0;
    nextDisabled = widget.currentWorkoutIndex ==
        widget.currentWorkoutCategory.workouts.length - 1;
    Size size = MediaQuery.of(context).size;
    return Container(
      key: widget.globalKey,
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
