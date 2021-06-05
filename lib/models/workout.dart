import 'package:flutter/material.dart';

enum Difficulty { Easy, Medium, Hard, Impossible }

class Workout {
  final String title;
  final String imageUrl;
  final Difficulty difficulty;
  final int workoutDuration;
  final double caloriesPerMinute;

  Workout(
      {@required this.title,
      @required this.imageUrl,
      @required this.workoutDuration,
      @required this.caloriesPerMinute,
      this.difficulty = Difficulty.Medium});
}
