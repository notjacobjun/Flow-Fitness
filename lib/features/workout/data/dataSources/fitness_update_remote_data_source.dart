import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';

abstract class FitnessUpdateRemoteDataSource {
  /// this method should get all the fitness updates associated with the
  /// currently logged in user and return ServerError if otherwise
  Future<List<FitnessUpdate>> getAllFitnessUpdates();
}

class FitnessUpdateRemoteDataSourceImpl
    implements FitnessUpdateRemoteDataSource {
  final http.Client client;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User currentUser = FirebaseAuth.instance.currentUser;

  FitnessUpdateRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<FitnessUpdate>> getAllFitnessUpdates() {
    firestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("fitnessUpdates")
        .get()
        .then((querySnapshot) {
      final updates = querySnapshot.docs.map((result) {
        // retrieving the data from firestore and converting it into a FitnessModelUpdate
        // then the map method adds this FitnessModelUpdate into the List updates
        FitnessUpdateModel.fromFirestore(result);
      });
      return updates;
    });
  }
}
