import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _firebaseAuth;

  UserService(this._firebaseAuth);

  bool incrementXP(double caloriesBurned, int currentLevel) {
    final User currentUser = _firebaseAuth.currentUser;
    final fireStoreInstance = FirebaseFirestore.instance;
    fireStoreInstance.
    var newXP = "Enter value here";
  }
}
