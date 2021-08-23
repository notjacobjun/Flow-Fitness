import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';

abstract class FitnessUpdateRemoteDataSource {
  /// This method gets the fitness updates for the currently logged in user and
  /// return the updates in the form of a Stream<List<FitnessUpdateModel>> it
  /// throws ServerError if otherwise
  Stream<List<FitnessUpdateModel>> getAllFitnessUpdates();

  /// This method
  Future<void> saveFitnessUpdate(FitnessUpdateModel fitnessUpdate);
}

class FitnessUpdateRemoteDataSourceImpl
    implements FitnessUpdateRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Stream<List<FitnessUpdateModel>> getAllFitnessUpdates() {
    // goes into firestore and retrieves the fitness updates for the current user
    var ref = firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('fitnessUpdates');
    if (ref.snapshots() == null) {
      print("Firestore returned null for user fitness updates");
    }
    ref.snapshots().forEach((list) {
      list.docs.forEach((doc) {
        print("updates from FitnessUpdateRemoteDataSource.dart: " +
            doc.data().toString());
      });
    });
    return ref.snapshots().map((list) => list.docs
        .map((doc) => FitnessUpdateModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  @override
  Future<void> saveFitnessUpdate(FitnessUpdateModel fitnessUpdateModel) async {
    final recentUpdate = fitnessUpdateModel.toJson();
    var ref = await firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("fitnessUpdates")
        .add(recentUpdate)
        .then((value) {
      print(value.id + " saved successfully into firestore");
    });
    return;
  }
}
