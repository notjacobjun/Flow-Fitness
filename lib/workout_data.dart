import 'models/workout.dart';

var WORKOUT_DATA = [
  Workout(
      title: "Scissors kicks",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 40,
      caloriesPerMinute: 12),
  Workout(
      title: "Extended arm lifts",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 40,
      caloriesPerMinute: 12.5),
  Workout(
      title: "Ab crunches",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 40,
      caloriesPerMinute: 10),
  Workout(
      title: "Heel lifts",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 35,
      caloriesPerMinute: 12),
  Workout(
      title: "Pushups",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 45,
      caloriesPerMinute: 15),
  Workout(
      title: "Sky reaches",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 45,
      caloriesPerMinute: 10),
  Workout(
      title: "Plank",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 50,
      caloriesPerMinute: 15),
  Workout(
      title: "Oblique lifts (left)",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 50,
      caloriesPerMinute: 9.8),
  Workout(
      title: "Oblique lifts (right)",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 50,
      caloriesPerMinute: 9.8),
  Workout(
      title: "Side planks (left)",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 40,
      caloriesPerMinute: 7.8),
  Workout(
      title: "Side planks (right)",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 40,
      caloriesPerMinute: 7.8),
  Workout(
      title: "Heel holds",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 45,
      caloriesPerMinute: 11),
  Workout(
      title: "Mountain climbers",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 40,
      caloriesPerMinute: 11),
  Workout(
      title: "Bicycle kicks",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 45,
      caloriesPerMinute: 11),
  Workout(
      title: "Diamond pushups",
      imageUrl:
          "https://www.fitnessandpower.com/wp-content/uploads/2016/02/crunch-exercises.jpg",
      workoutDuration: 30,
      caloriesPerMinute: 12),
];

// TODO convert this into a Provider
// class Workouts with ChangeNotifier {
//   List<Workout> workouts = [];
//
//   // check if this works
//   Workouts(this.workouts) {
//     workouts.addAll(WORKOUT_DATA);
//     this.workouts = workouts;
//   }
//
//   List<Workout> get workouts {
//     return [...workouts];
//   }
// }
