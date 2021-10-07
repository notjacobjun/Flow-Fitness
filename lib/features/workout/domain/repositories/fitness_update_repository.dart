import 'package:dartz/dartz.dart';
import 'package:interactive_workout_app/core/errors/failures.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';

abstract class FitnessUpdateRepository {
  /// this method should get all the fitness updates associated with the
  /// currently logged in user and return ServerError if otherwise
  Future<Either<Failure, Stream<List<FitnessUpdate>>>> getAllFitnessUpdates();

  /// This method should retrieve the fitness updates associated with the currently
  /// logged in user within the past 7 days and return ServerError if otherwise
  Future<Either<Failure, List<FitnessUpdate>>> getRecentFitnessUpdates();

  /// This method should create a new FitnessUpdate when the user finished a workout
  /// then it should save this update into our designated database in the cloud.
  /// If there is an error then it should return ServerError
  Future<Either<Failure, void>> saveFitnessUpdate(
      FitnessUpdateModel fitnessUpdateModel);

  // TODO configure these with the correct arguments
  // Future<Either<Failure, FitnessUpdate>> loginUser();
  // Future<Either<Failure, FitnessUpdate>> registerUser();
}
