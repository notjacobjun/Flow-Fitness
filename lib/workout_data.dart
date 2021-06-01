import 'package:flutter/material.dart';

import 'models/workout.dart';

const WORKOUT_CATEGORIES = const [
  Workout(
      title: "7-Minute Abs",
      category: Category.Abdominal,
      color: Colors.red,
      image: 'assets/images/ab-workout-image.jpg'),
  Workout(
      title: "Quick arms",
      category: Category.Arm,
      color: Colors.lime,
      image: "assets/images/arm-workout-image.jpg"),
  Workout(
      title: "Full body",
      category: Category.All,
      color: Colors.deepPurple,
      image: "assets/images/full-body-workout-image.jpg"),
  Workout(
      title: "Cardio at home",
      category: Category.Cardio,
      color: Colors.amber,
      image: "assets/images/cardio-image.jpg"),
  Workout(
      title: "Leg workout",
      category: Category.Legs,
      color: Colors.black,
      image: "assets/images/leg-workout-image.jpg"),
  Workout(title: "Test", category: Category.All, color: Colors.deepPurple),
  Workout(title: "Test", category: Category.All, color: Colors.deepPurple),
  Workout(title: "Test", category: Category.All, color: Colors.deepPurple),
];
