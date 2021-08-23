import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';

class FitnessUpdateModel extends FitnessUpdate with ChangeNotifier {
  FitnessUpdateModel(
      {@required DateTime dateTime,
      @required double caloriesBurned,
      @required int totalWorkoutTime,
      @required String workoutTitle,
      String id})
      : super(
            workoutTitle: workoutTitle,
            totalWorkoutTime: totalWorkoutTime,
            dateTime: dateTime,
            caloriesBurned: caloriesBurned,
            id: id);

  /// This method takes in JSON in the form of a Map and then converts
  /// the JSON into a FitnessUpdateModel note that this method doesn't take
  /// because the id is only provided by firestore and should only be created by
  /// firestore. If you need to convert a json object with an id parameter then
  /// try using the fromFirestore method instead or converting it manually.
  factory FitnessUpdateModel.fromJson(Map<String, dynamic> json) {
    return new FitnessUpdateModel(
      dateTime: DateTime.parse(json['dateTime'].toDate().toString()),
      caloriesBurned: (json['caloriesBurned'] as num).toDouble(),
      workoutTitle: json['workoutTitle'],
      totalWorkoutTime: (json['totalWorkoutTime'] as num).toInt(),
    );
  }

  /// Method that takes in the data from Firestore and ensures that it is converted
  /// a FitnessUpdateModel with the id set because Firestore doesn't give the id
  /// when you query the data from Firestore. This method also has default for
  /// empty values for each field except dateTime
  factory FitnessUpdateModel.fromMap(Map snapshot, String id) {
    return new FitnessUpdateModel(
      id: snapshot['id'] ?? "",
      caloriesBurned: snapshot['caloriesBurned'] ?? 0,
      workoutTitle: snapshot['workoutTitle'] ?? "No workout title set",
      dateTime: DateTime.parse(snapshot['dateTime']) ?? DateTime.now(),
      totalWorkoutTime: snapshot['totalWorkoutTime'] ?? 0,
    );
  }

  /// This method takes in a FitnessUpdateModel and then converts
  /// it into stringified JSON. Note that this method takes in the id from the
  /// fitness update model even though the fromJson method doesn't take in the
  /// id (for more detials check out the documentation for the fromJson method)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toString(),
      'caloriesBurned': caloriesBurned,
      'workoutTitle': workoutTitle,
      'totalWorkoutTime': totalWorkoutTime,
    };
  }

  /// This method takes in a documentSnapshot from Firestore and then converts
  /// it into a FitnessUpdateModel. The primary function of this method is to
  /// also include the id when transferring from Firestore because by default
  /// Firestore doesn't include the id (this method is deprecated by the fromMap method)
  factory FitnessUpdateModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    FitnessUpdateModel fitnessUpdateModel = FitnessUpdateModel.fromJson(
        json.decode(documentSnapshot.data().toString()));
    fitnessUpdateModel.id = documentSnapshot.id;
    return fitnessUpdateModel;
  }

  void updateFitnessUpdateInfo(FitnessUpdate info) {
    // check before because we try to use Firebase to generate the UID for us
    if (info.id != null) {
      id = info.id;
    }
    dateTime = info.dateTime;
    caloriesBurned = info.caloriesBurned;
    workoutTitle = info.workoutTitle;
    totalWorkoutTime = info.totalWorkoutTime;
    notifyListeners();
  }
}
