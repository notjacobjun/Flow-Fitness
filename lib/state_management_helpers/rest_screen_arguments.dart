class RestScreenArguments {
  final int previousWorkoutIndex;
  final String currentWorkoutCategoryTitle;
  final int totalWorkoutTime;
  final double totalCaloriesBurned;

  RestScreenArguments(
      {this.previousWorkoutIndex,
      this.currentWorkoutCategoryTitle,
      this.totalWorkoutTime,
      this.totalCaloriesBurned});

  String get categoryTitle {
    return currentWorkoutCategoryTitle;
  }
}
