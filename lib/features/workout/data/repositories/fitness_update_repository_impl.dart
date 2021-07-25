import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:interactive_workout_app/core/errors/expetions.dart';
import 'package:interactive_workout_app/core/errors/failures.dart';
import 'package:interactive_workout_app/core/network/network_info.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';

class FitnessUpdateRepositoryImpl implements FitnessUpdateRepository {
  final NetworkInfo networkInfo;
  final FitnessUpdateRemoteDataSource remoteDataSource;

  FitnessUpdateRepositoryImpl(
      {@required this.networkInfo, @required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FitnessUpdate>>> getAllFitnessUpdates() async {
    if (await networkInfo.isConnected) {
      try {
        final fitnessUpdates = await remoteDataSource.getAllFitnessUpdates();
        return Right(fitnessUpdates);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        // final localTrivia = await localDataSource.getLastNumberTrivia();
        // return Right(localTrivia);
        print("do something on the local remote source");
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<FitnessUpdate>>> getRecentFitnessUpdates() async {
    if (await networkInfo.isConnected) {
      try {
        // fetch the updates from firestore
        final fitnessUpdates = await remoteDataSource.getAllFitnessUpdates();
        // parse through the updates and only return the updates within the past 7 days.
        List<FitnessUpdate> recentFitnessUpdates;
        fitnessUpdates.forEach((element) {
          if (element.dateTime
              .isAfter(DateTime.now().subtract(Duration(days: 7)))) {
            recentFitnessUpdates.add(element);
          }
        });
        return Right(recentFitnessUpdates);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        // final localTrivia = await localDataSource.getLastNumberTrivia();
        // return Right(localTrivia);
        print("do something on the local remote source");
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, FitnessUpdate>> saveFitnessUpdate(
      FitnessUpdate fitnessUpdate) {
    // TODO: implement saveFitnessUpdate
    throw UnimplementedError();
  }
}
