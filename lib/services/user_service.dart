import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  int nextLevel(int level) {
    final exponent = 1.5;
    final baseXP = 10;
    final res = baseXP * pow(level, exponent);
    return res.floor();
  }

  Future<String> getGuild() {
    try {
      final User currentUser = _firebaseAuth.currentUser;
      final String currentUID = currentUser.uid;
      final fireStoreInstance = FirebaseFirestore.instance;
      var guild;
      fireStoreInstance
          .collection("users")
          .doc(currentUID)
          .get()
          .then((value) => guild = value.data()["guild"]);
      return guild;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> getUserName() async {
    try {
      final User currentUser = _firebaseAuth.currentUser;
      final String currentUID = currentUser.uid;
      final fireStoreInstance = FirebaseFirestore.instance;
      var name;
      // note that we have to await here or else we will get null values
      await fireStoreInstance
          .collection("users")
          .doc(currentUID)
          .get()
          .then((value) {
        name = value.data()["name"];
      });
      return name;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateUsersDB(double caloriesBurned) async {
    try {
      final User currentUser = _firebaseAuth.currentUser;
      final String currentUID = currentUser.uid;
      final fireStoreInstance = FirebaseFirestore.instance;
      var previousCaloriesBurned;
      var currentLevel;
      // note that we have to await here or else we will get null values
      await fireStoreInstance
          .collection("users")
          .doc(currentUID)
          .get()
          .then((value) {
        previousCaloriesBurned = value.data()["caloriesBurned"];
        currentLevel = value.data()["level"];
      });
      final newCaloriesBurned = previousCaloriesBurned + caloriesBurned;
      while (newCaloriesBurned >= nextLevel(currentLevel)) {
        currentLevel++;
      }
      fireStoreInstance.collection("users").doc(currentUID).update({
        "caloriesBurned": previousCaloriesBurned + caloriesBurned,
        "level": currentLevel,
      });
    } catch (e) {
      print(e);
      print("An error happened when updating the user's information");
    }
  }
}
