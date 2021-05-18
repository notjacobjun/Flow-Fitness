import 'package:flutter/material.dart';

enum Category { Abdominal, Arm, Legs, Cardio, All }

class Workout {
  final String title;
  final Category category;
  final Color color;

  const Workout(
      {@required this.title,
      @required this.category,
      this.color = Colors.orange});
}
