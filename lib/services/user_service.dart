import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // final List<FitnessUpdate> recentUpdates;

  int nextLevel(int level) {
    final exponent = 1.5;
    final baseXP = 10;
    final res = baseXP * pow(level, exponent);
    return res.floor();
  }

  Future<String> getGuild() async {
    try {
      final User currentUser = _firebaseAuth.currentUser;
      final String currentUID = currentUser.uid;
      final fireStoreInstance = FirebaseFirestore.instance;
      var guild;
      await fireStoreInstance
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
      // fetching the user data from cloud firestore asynchronously
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

  // List<Map<String, Object>> get recentCalorieBurnData {
  //   // generates the week days for the past 7 days based on the index values
  //   // and the current date
  //   return List.generate(7, (index) {
  //     final weekDay = DateTime.now().subtract(
  //       Duration(days: index),
  //     );
  //     var totalSum = 0.0;

  //     for (var i = 0; i < recentTransactions.length; i++) {
  //       if (recentTransactions[i].date.day == weekDay.day &&
  //           recentTransactions[i].date.month == weekDay.month &&
  //           recentTransactions[i].date.year == weekDay.year) {
  //         totalSum += recentTransactions[i].amount;
  //       }
  //     }
  //     print(DateFormat.E().format(weekDay));
  //     print(totalSum);

  //     return {
  //       "day": DateFormat.E().format(weekDay).substring(0, 1),
  //       "amount": totalSum
  //     };
  //   }).reversed.toList();
  // }

  // double get totalSpending {
  //   return groupedTransactionValues.fold(0.0, (sum, item) {
  //     return sum + item['amount'];
  //   });
  // }
}
