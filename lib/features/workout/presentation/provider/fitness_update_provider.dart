import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:interactive_workout_app/core/network/network_info.dart';
import 'package:interactive_workout_app/core/useCases/usecase.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/repositories/fitness_update_repository_impl.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/get_all_fitness_updates.dart';

class FitnessUpdateList extends ChangeNotifier {
  var _updates;

  FitnessUpdateList(this._updates);

  List<FitnessUpdate> get orders {
    // creating a new list with the items from _orders, this prevent changes
    // from outside the class
    return [..._updates];
  }

  // TODO adding these might violate the architecture of the app
  Future<void> getFitnessUpdates() async {
    final NetworkInfoImpl networkInfo =
        NetworkInfoImpl(DataConnectionChecker());
    final Client httpClient = Client();
    final FitnessUpdateRemoteDataSourceImpl remoteDataSourceImpl =
        FitnessUpdateRemoteDataSourceImpl(client: httpClient);
    final FitnessUpdateRepositoryImpl repositoryImpl =
        FitnessUpdateRepositoryImpl(
            networkInfo: networkInfo, remoteDataSource: remoteDataSourceImpl);
    final useCase = GetAllFitnessUpdates(repositoryImpl);
    _updates = await useCase.call(NoParams());
    notifyListeners();
  }

  Future<void> addFitnessUpdate() {}
}
