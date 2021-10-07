import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final mockFitnessUpdateModel = FitnessUpdateModel(
    id: "test fitness update",
    workoutTitle: "test fitness update model workout",
    totalWorkoutTime: 20,
    caloriesBurned: 40.22,
    dateTime: DateTime.parse("2021-07-16 21:51:53.092"),
  );

  test("Should be a subclass of fitness update entity", () async {
    // assert
    expect(mockFitnessUpdateModel, isA<FitnessUpdate>());
  });

  group("fromJSON", () {
    test('should return valid model when valid json form is given', () async {
      // arrange
      // converts the json from the file 'fitness_update.json' into a String then it decodes that Stringified json object
      // into a Map<String, dynamic>
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('fitness_update.json'));
      // act
      final result = FitnessUpdateModel.fromJson(jsonMap);
      // assert
      expect(result, equals(mockFitnessUpdateModel));
    });
  });

  group("toJSON", () {
    test(
        'should return JSON formatted fitess update model when given a valid fitness update model',
        () async {
      // arrange
      final result = mockFitnessUpdateModel.toJson();
      // assert
      final expectedMap = {
        "id": "test fitness update",
        "workoutTitle": "test fitness update model workout",
        "totalWorkoutTime": 20,
        "caloriesBurned": 40.22,
        "dateTime": "2021-07-16 21:51:53.092",
      };
      expect(result, expectedMap);
    });
  });

  group("fromMap", () {
    test('should return FitnessUpdateModel that was transformed from an object',
        () async {
      // act
      var testObject = {
        "workoutTitle": "test fitness update model workout",
        "totalWorkoutTime": 20,
        "caloriesBurned": 40.22,
        // converted to Timestamp to replicate Firestore's actual return type
        "dateTime": Timestamp(1626980400, 0)
      };
      FitnessUpdateModel result =
          FitnessUpdateModel.fromMap(testObject, "test fitness update");
      // assert
      // TODO WHY IS THIS EXPECT STATEMENT NOT WORKING!!!!!!!!!
      expect(result, mockFitnessUpdateModel);
    });
  });
}
