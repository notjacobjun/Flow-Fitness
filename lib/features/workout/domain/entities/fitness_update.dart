import 'package:flutter/foundation.dart';

class FitnessUpdate {
  String id;
  final DateTime dateTime;
  final double caloriesBurned;
  final String workoutTitle;
  final int totalWorkoutTime;

  FitnessUpdate(
      {@required this.dateTime,
      @required this.caloriesBurned,
      @required this.workoutTitle,
      @required this.totalWorkoutTime,
      @required this.id});
}
