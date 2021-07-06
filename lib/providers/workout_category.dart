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
      color: Color(0xFFff7e5f),
      description: "Quick ab workout with no equipment necessary",
      image: 'assets/images/ab_workout.png',
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
        color: Colors.blue.shade100,
        description: "Quick 20 min workout for the upper body",
        image: "assets/images/arm_workout.png",
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
        image: "assets/images/full_body_workout.png",
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
        image: "assets/images/cardio.png"),
    InnerWorkoutCategoryItem(
        title: "Leg workout",
        category: TargetMuscles.Legs,
        color: Colors.amber,
        image: "assets/images/leg_workout.png"),
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

  InnerWorkoutCategoryItem findCategory(String title) {
    return _categories.firstWhere((category) => category.title == title);
  }

  void resetWorkoutTimes(InnerWorkoutCategoryItem currentWorkout) {
    currentWorkout.workouts.forEach((workout) {
      workout.workoutDuration = CONSTANT_WORKOUT_DATA
          .firstWhere((workoutData) => workoutData.title == workout.title)
          .workoutDuration;
    });
  }
}
