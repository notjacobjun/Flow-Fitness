import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:interactive_workout_app/core/errors/failures.dart';
import 'package:interactive_workout_app/core/useCases/usecase.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';

class SaveFitnessUpdate implements UseCase<FitnessUpdate, Params> {
  final FitnessUpdateRepository repository;

  SaveFitnessUpdate(this.repository);

  @override
  Future<Either<Failure, FitnessUpdate>> call(Params params) async {
    return await repository.saveFitnessUpdate(params.fitnessUpdate);
  }
}

class Params extends Equatable {
  final FitnessUpdate fitnessUpdate;

  Params({@required this.fitnessUpdate});

  @override
  List<Object> get props => [fitnessUpdate];
}
