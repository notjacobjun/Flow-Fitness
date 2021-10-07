import 'package:interactive_workout_app/features/workout/presentation/provider/workout_category.dart';

class ResultsScreenArguments {
  final InnerWorkoutCategoryItem currentWorkoutCategory;
  final int totalWorkoutTime;
  final double totalCaloriesBurned;
  final String currentWorkoutCategoryTitle;

  ResultsScreenArguments(
      {this.currentWorkoutCategory,
      this.currentWorkoutCategoryTitle,
      this.totalWorkoutTime,
      this.totalCaloriesBurned});
}
