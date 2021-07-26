import 'package:interactive_workout_app/features/workout/presentation/provider/workout_category.dart';

class ResultsScreenArguments {
  final InnerWorkoutCategoryItem currentWorkoutCategory;
  final int totalWorkoutTime;
  final double totalCaloriesBurned;

  ResultsScreenArguments(
      {this.currentWorkoutCategory,
      this.totalWorkoutTime,
      this.totalCaloriesBurned});
}
