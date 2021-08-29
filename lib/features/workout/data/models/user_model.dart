import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/user.dart';

class UserModel extends User with ChangeNotifier {
  UserModel(
      {String id,
      String name,
      String email,
      int level,
      double totalWorkoutTime,
      double caloriesBurned,
      String description,
      String guild,
      String profilePicture})
      : super(
            caloriesBurned: caloriesBurned,
            description: description,
            email: email,
            guild: guild,
            id: id,
            level: level,
            totalWorkoutTime: totalWorkoutTime,
            profilePicture: profilePicture,
            name: name);

  UserModel.froMap(Map snapshot, String id) {}

  /// This method takes in JSON in the form of a Map and then converts
  /// the JSON into a UserModel note that this method doesn't take
  /// because the id is only provided by firestore and should only be created by
  /// firestore. If you need to convert a json object with an id parameter then
  /// try using the fromFirestore method instead or converting it manually.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return new UserModel(
      name: json['name'],
      email: json['email'],
      level: (json['level'] as num).toInt(),
      totalWorkoutTime: (json['totalWorkoutTime'] as num).toDouble(),
      caloriesBurned: (json['caloriesBurned'] as num).toDouble(),
      description: json['description'],
      guild: json['guild'],
      profilePicture: json['profilePicture'],
    );
  }

  /// Method that takes in the data from Firestore and ensures that it is converted
  /// a UserModel with the id set because Firestore doesn't give the id
  /// when you query the data from Firestore.
  factory UserModel.fromMap(Map snapshot, String id) {
    return new UserModel(
      id: snapshot['id'] ?? "",
      name: snapshot['name'] ?? "",
      caloriesBurned: snapshot['caloriesBurned'] ?? 0,
      totalWorkoutTime: snapshot['totalWorkoutTime'] ?? 0,
      email: snapshot['email'] ?? "",
      level: snapshot['level'] ?? -1,
      description: snapshot['description'] ?? "No description set",
      guild: snapshot['guild'] ?? "",
      profilePicture: snapshot['profilePicture'] ?? "",
    );
  }

  /// This method takes in a UserModel and then converts
  /// it into stringified JSON. Note that this method takes in the id from the
  /// fitness update model even though the fromJson method doesn't take in the
  /// id (for more detials check out the documentation for the fromJson method)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'caloriesBurned': caloriesBurned,
      'totalWorkoutTime': totalWorkoutTime,
      'level': level,
      'description': description,
      'guild': guild,
      'profilePicture': profilePicture,
    };
  }
}
