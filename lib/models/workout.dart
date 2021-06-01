import 'package:flutter/material.dart';

enum Category { Abdominal, Arm, Legs, Cardio, All }

class Workout {
  final String title;
  final Category category;
  final String description;
  final Color color;
  final String image;

  const Workout(
      {@required this.title,
      @required this.category,
      this.description,
      this.image,
      this.color = Colors.orange});
}
