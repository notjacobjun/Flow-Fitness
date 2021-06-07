import 'package:interactive_workout_app/models/workout_category.dart';

class ResultsScreenArguments {
  final InnerWorkoutCategoryItem currentWorkoutCategory;
  final int totalWorkoutTime;
  final double totalCaloriesBurned;

  ResultsScreenArguments(
      {this.currentWorkoutCategory,
      this.totalWorkoutTime,
      this.totalCaloriesBurned});
}
