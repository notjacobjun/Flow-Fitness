import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/get_all_fitness_updates.dart';

import '../../../../injection_container.dart';

class FitnessUpdateList extends ChangeNotifier {
  List<FitnessUpdate> _updates = [];
  final GetAllFitnessUpdates getAllFitnessUpdates;

  FitnessUpdateList(this.getAllFitnessUpdates);

  List<FitnessUpdate> get updates {
    // creating a new list with the items from _updates, this prevent changes
    // from outside the class
    return [..._updates];
  }

  // Stream<List<FitnessUpdate>> _eitherLoadedOrErrorState(
  //   Either<Failure, FitnessUpdate> failureOrUpdate,
  // ) async* {
  //   yield failureOrUpdate.fold(
  //       (failure) => Error(message: _mapFailureToMessage(failure)),
  //       (trivia) => remoteDataSource.getAllFitnessUpdates() as List);
  // }

  // Future<Stream<List<FitnessUpdate>>> streamOfFitnessUpdates() async {
  //   final failureOrUpdates = await getAllFitnessUpdates.call(NoParams());
  //   if (failureOrUpdates is Failure) {
  //     print(failureOrUpdates.toString());
  //   }
  //   return failureOrUpdates;
  // }

  // Future<List<FitnessUpdate>> fetchFitnessUpdates() async {
  //   _updates = getAllFitnessUpdates.call(NoParams());
  // }

  Stream<List<FitnessUpdateModel>> streamOfFitnessUpdates() {
    final remoteDataSource = sl<FitnessUpdateRemoteDataSource>();
    return remoteDataSource.getAllFitnessUpdates();
  }

  Future<void> addFitnessUpdate() {}
}
