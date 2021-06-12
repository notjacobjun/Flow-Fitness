import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return "Wrong credentials";
    }
  }

  Future<String> signUp({String name, String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final fireStoreInstance = FirebaseFirestore.instance;
      fireStoreInstance.collection("users").add({
        "name": name,
        "email": email,
        "caloriesBurned": 0,
        "level": 1,
      });
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
