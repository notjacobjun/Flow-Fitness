class User {
  final String id;
  final String name;
  final String email;
  final double totalWorkoutTime;
  final int level;
  final double caloriesBurned;
  final String description;
  final String guild;
  final String profilePicture;

  User(
      {this.id,
      this.name,
      this.email,
      this.level,
      this.totalWorkoutTime,
      this.caloriesBurned,
      this.description,
      this.guild,
      this.profilePicture});
}
