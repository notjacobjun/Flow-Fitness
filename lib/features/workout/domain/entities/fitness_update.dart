import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FitnessUpdate {
  String id;
  DateTime dateTime;
  double caloriesBurned;
  String workoutTitle;
  int totalWorkoutTime;

  FitnessUpdate(
      {@required this.dateTime,
      @required this.caloriesBurned,
      @required this.workoutTitle,
      @required this.totalWorkoutTime,
      this.id});

  FitnessUpdate get currentFitnessUpdate {
    return FitnessUpdate(
      dateTime: dateTime,
      caloriesBurned: caloriesBurned,
      workoutTitle: workoutTitle,
      totalWorkoutTime: totalWorkoutTime,
      id: id,
    );
  }
}
