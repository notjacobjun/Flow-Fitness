class RestScreenArguments {
  final int previousWorkoutIndex;
  final String currentWorkoutCategoryTitle;

  RestScreenArguments(
      {this.previousWorkoutIndex, this.currentWorkoutCategoryTitle});

  String get categoryTitle {
    return currentWorkoutCategoryTitle;
  }
}
