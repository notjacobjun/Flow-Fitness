import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/user_model.dart';
import 'package:interactive_workout_app/features/workout/data/repositories/fitness_update_repository_impl.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/get_all_fitness_updates.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/get_recent_fitness_updates.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/save_fitness_update.dart';
import 'package:interactive_workout_app/features/workout/presentation/provider/fitness_update_list.dart';
import 'package:interactive_workout_app/services/user_service.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia

  // Provider
  sl.registerFactory(() => FitnessUpdateList(sl()));
  sl.registerFactory(() => UserModel());
  // Use cases
  sl.registerLazySingleton(() => GetAllFitnessUpdates(sl()));
  sl.registerLazySingleton(() => GetRecentFitnessUpdates(sl()));
  sl.registerLazySingleton(() => SaveFitnessUpdate(sl()));

  // Repository
  // we specify the type to prevent any type errors within this injection container
  sl.registerLazySingleton<FitnessUpdateRepository>(() =>
      FitnessUpdateRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<FitnessUpdateRemoteDataSource>(
      () => FitnessUpdateRemoteDataSourceImpl());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => UserService());
}
