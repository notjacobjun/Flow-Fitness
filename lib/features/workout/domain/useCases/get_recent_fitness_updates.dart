import 'package:dartz/dartz.dart';
import 'package:interactive_workout_app/core/errors/failures.dart';
import 'package:interactive_workout_app/core/useCases/usecase.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';

class GetRecentFitnessUpdates
    implements UseCase<List<FitnessUpdate>, NoParams> {
  final FitnessUpdateRepository repository;

  GetRecentFitnessUpdates(this.repository);

  @override
  Future<Either<Failure, List<FitnessUpdate>>> call(NoParams params) async {
    return await repository.getRecentFitnessUpdates();
  }
}
