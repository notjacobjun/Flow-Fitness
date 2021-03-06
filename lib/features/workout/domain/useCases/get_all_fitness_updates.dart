import 'package:dartz/dartz.dart';
import 'package:interactive_workout_app/core/errors/failures.dart';
import 'package:interactive_workout_app/core/useCases/usecase.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';

class GetAllFitnessUpdates
    implements UseCase<Stream<List<FitnessUpdate>>, NoParams> {
  final FitnessUpdateRepository repository;

  GetAllFitnessUpdates(this.repository);

  @override
  Future<Either<Failure, Stream<List<FitnessUpdate>>>> call(NoParams params) {
    // TODO add some error handling logic here using dartz package
    return repository.getAllFitnessUpdates();
  }

  // @override
  // Future<Either<Failure, <List<FitnessUpdate>>> call(
  //     NoParams params) async {
  //   return await repository.getAllFitnessUpdates();
  // }
}
