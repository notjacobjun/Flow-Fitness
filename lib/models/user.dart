class User {
  final int id;
  final String userName;
  final String email;
  final int level;
  final double caloriesBurned;
  final List<User> friends;

  User(
      {this.id,
      this.userName,
      this.email,
      this.caloriesBurned,
      this.level,
      this.friends});
}
