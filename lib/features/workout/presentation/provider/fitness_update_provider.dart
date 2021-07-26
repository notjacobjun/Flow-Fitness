import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/data/repositories/fitness_update_repository_impl.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/get_all_fitness_updates.dart';

class FitnessUpdateList extends ChangeNotifier {
  var _updates;
  FitnessUpdateRemoteDataSource remoteDataSource =
      FitnessUpdateRemoteDataSourceImpl();

  FitnessUpdateList(this._updates);

  List<FitnessUpdate> get updates {
    // creating a new list with the items from _updates, this prevent changes
    // from outside the class
    return [..._updates];
  }

  Stream<List<FitnessUpdateModel>> streamOfFitnessUpdates() {
    return remoteDataSource.getAllFitnessUpdates();
  }

  Future<void> addFitnessUpdate() {}
}
