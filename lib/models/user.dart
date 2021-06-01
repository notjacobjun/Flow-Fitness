enum Fitness { Beginner, Intermediate, Advanced }

class User {
  final String userName;
  final String email;
  final Fitness fitness;
  final List<User> friends;

  User({this.userName, this.email, this.fitness, this.friends});
}
