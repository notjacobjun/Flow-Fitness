import 'package:flutter/material.dart';
import 'package:interactive_workout_app/core/errors/failures.dart';
import 'package:interactive_workout_app/core/useCases/usecase.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/get_all_fitness_updates.dart';

import '../../../../injection_container.dart';

class FitnessUpdateList extends ChangeNotifier {
  List<FitnessUpdateModel> fitnessUpdates = [];

  List<FitnessUpdateModel> get updates {
    // creating a new list with the items from _updates, this prevent changes
    // from outside the class
    return [...fitnessUpdates];
  }

  void printUpdates() {
    fitnessUpdates.forEach((element) {
      print("update from fitness update List provider: " + element.toString());
    });
  }

  List<FitnessUpdateModel> getRecentUpdates() {
    getFitnessUpdatesFromFirestore();
    if (fitnessUpdates.isEmpty) {
      print("The updates list is empty");
    }
    List<FitnessUpdateModel> recentUpdates;
    recentUpdates = fitnessUpdates.map((update) {
      if (update.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)))) {
        print(update.caloriesBurned.toString() +
            " in RecentUpdates of fitness_update_list.dart");
        return update;
      }
    }).toList();
    notifyListeners();
    return recentUpdates;
  }

  Future<void> getFitnessUpdatesFromFirestore() async {
    final failureOrUpdates = await sl<GetAllFitnessUpdates>().call(NoParams());
    failureOrUpdates.fold((failure) {
      print("failure occured");
      ServerFailure();
    }, (updates) {
      // TODO maybe the stream here is not open during the time that we want it to be open
      updates.listen((event) {
        event.forEach((element) {
          fitnessUpdates.add(element);
          print(element.toString() + " from fitness_update_list.dart");
        });
        // _updates.forEach((element) {
        //   print(
        //       element.workoutTitle + " _updates from fitness_update_list.dart");
        // });
      });
    });
    notifyListeners();
  }

// Stream version of getFitnessUpdatesFromFireStore
  //   Stream<void> getFitnessUpdatesFromFirestore() async* {
  //   final failureOrUpdates = await sl<GetAllFitnessUpdates>()(NoParams());
  //   yield* failureOrUpdates.fold((failure) async* {
  //     print("failure occured");
  //     yield ServerFailure();
  //   }, (updates) async* {
  //     // TODO maybe the stream here is not open during the time that we want it to be open
  //     yield updates.listen((event) {
  //       // event.forEach((element) {
  //       //   print(element.toString() + " from fitness_update_list.dart");
  //       // });
  //       _updates = event;
  //       // _updates.forEach((element) {
  //       //   print(
  //       //       element.workoutTitle + " _updates from fitness_update_list.dart");
  //       // });
  //     });
  //   });
  //   notifyListeners();
  // }

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

  // TODO reconfigure this to use the useCase instead
  // Also this method might be causing the problem with home screen
  Stream<List<FitnessUpdateModel>> streamOfFitnessUpdates() {
    final remoteDataSource = sl<FitnessUpdateRemoteDataSource>();
    return remoteDataSource.getAllFitnessUpdates();
  }
}
