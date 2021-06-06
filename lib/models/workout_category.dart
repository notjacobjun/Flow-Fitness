import 'package:flutter/material.dart';
import 'package:interactive_workout_app/models/workout.dart';

import '../workout_data.dart';

enum TargetMuscles { Abdominal, Arm, Legs, All }

class InnerWorkoutCategoryItem {
  final String title;
  final TargetMuscles category;
  final String description;
  final Color color;
  final String image;
  final List<Workout> workouts;

  InnerWorkoutCategoryItem(
      {@required this.title,
      @required this.category,
      this.description,
      this.image,
      this.color = Colors.orange,
      this.workouts});
}

class WorkoutCategory with ChangeNotifier {
  List<InnerWorkoutCategoryItem> _categories = [
    InnerWorkoutCategoryItem(
      title: "14-Minute Abs",
      category: TargetMuscles.Abdominal,
      color: Colors.red,
      description: "Quick ab workout, no equipment necessary",
      image: 'assets/images/ab-workout-image.jpg',
      workouts: [
        WORKOUT_DATA.singleWhere((workout) => workout.title == "Ab crunches"),
        WORKOUT_DATA.singleWhere((workout) => workout.title == "Sky reaches"),
        WORKOUT_DATA
            .singleWhere((workout) => workout.title == "Extended arm lifts"),
        WORKOUT_DATA.singleWhere((workout) => workout.title == "Heel lifts"),
        WORKOUT_DATA.singleWhere((workout) => workout.title == "Plank"),
        WORKOUT_DATA
            .singleWhere((workout) => workout.title == "Mountain climbers"),
        WORKOUT_DATA.singleWhere((workout) => workout.title == "Bicycle kicks"),
        WORKOUT_DATA
            .singleWhere((workout) => workout.title == "Oblique lifts (left)"),
        WORKOUT_DATA
            .singleWhere((workout) => workout.title == "Oblique lifts (right)"),
      ],
    ),
    InnerWorkoutCategoryItem(
        title: "Quick arms",
        category: TargetMuscles.Arm,
        color: Colors.grey,
        description: "Quick 20 min workout for the upper body",
        image: "assets/images/arm-workout-image.jpg",
        workouts: [
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Bicep curls (right)"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Bicep curls (left)"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Gentleman's curls"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Gentleman's curls"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Pushups"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Chin ups"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Shoulder presses"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Shoulder presses"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Shoulder presses"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Tricep dips"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Tricep dips"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Tricep dips"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Diamond pushups"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Diamond pushups"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Diamond pushups"),
        ]),
    InnerWorkoutCategoryItem(
        title: "Full body",
        category: TargetMuscles.All,
        color: Colors.deepPurple,
        image: "assets/images/full-body-workout-image.jpg",
        workouts: [
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Pushups"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Pushups"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Diamond pushups"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Diamond pushups"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Tricep dips"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Tricep dips"),
          WORKOUT_DATA.singleWhere(
              (workout) => workout.title == "Military jumping jacks"),
          WORKOUT_DATA.singleWhere(
              (workout) => workout.title == "Military jumping jacks"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Mountain climbers"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Bicycle kicks"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Scissor kicks"),
          WORKOUT_DATA.singleWhere((workout) => workout.title == "Plank"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Side plank (left)"),
          WORKOUT_DATA
              .singleWhere((workout) => workout.title == "Side plank (right)"),
        ]),
    InnerWorkoutCategoryItem(
        title: "Cardio at home",
        category: TargetMuscles.Legs,
        color: Colors.amber,
        image: "assets/images/cardio-image.jpg"),
    InnerWorkoutCategoryItem(
        title: "Leg workout",
        category: TargetMuscles.Legs,
        color: Colors.amber,
        image: "assets/images/leg-workout-image.jpg"),
    InnerWorkoutCategoryItem(
        title: "Test", category: TargetMuscles.All, color: Colors.deepPurple),
    InnerWorkoutCategoryItem(
        title: "Test", category: TargetMuscles.All, color: Colors.deepPurple),
    InnerWorkoutCategoryItem(
        title: "Test", category: TargetMuscles.All, color: Colors.deepPurple),
  ];

  List<InnerWorkoutCategoryItem> get categories {
    return [..._categories];
  }

  // List<InnerWorkoutCategoryItem> get workouts {
  //   return this.workouts;
  // }

  InnerWorkoutCategoryItem findCategory(String title) {
    return _categories.firstWhere((category) => category.title == title);
  }
}
