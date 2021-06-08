import 'package:interactive_workout_app/providers/workout_category.dart';

class WorkoutScreenArguments {
  final String currentWorkoutCategoryTitle;
  final InnerWorkoutCategoryItem currentWorkoutCategory;
  final int upcomingWorkoutIndex;
  final int totalWorkoutTime;
  final double totalCaloriesBurned;

  // goes from workout category item -> WorkoutScreen -> Workout Timer -> RestScreen or Results screen -> Transition Timer -> WorkoutScreen
  WorkoutScreenArguments(
      {this.currentWorkoutCategoryTitle,
      this.upcomingWorkoutIndex,
      this.totalWorkoutTime,
      this.currentWorkoutCategory,
      this.totalCaloriesBurned});
}
