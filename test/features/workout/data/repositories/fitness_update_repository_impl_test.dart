import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_workout_app/core/errors/expetions.dart';
import 'package:interactive_workout_app/core/errors/failures.dart';
import 'package:interactive_workout_app/core/network/network_info.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/data/repositories/fitness_update_repository_impl.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements FitnessUpdateRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  FitnessUpdateRepositoryImpl fitnessUpdateRepositoryImpl =
      FitnessUpdateRepositoryImpl(
          networkInfo: mockNetworkInfo, remoteDataSource: mockRemoteDataSource);

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group("SaveFitnessUpdate", () {
    final FitnessUpdateModel testFitnessUpdateModel = FitnessUpdateModel(
        dateTime: DateTime(2020, 8, 21),
        caloriesBurned: 50,
        workoutTitle: "testWorkoutTitle",
        totalWorkoutTime: 20,
        id: "test fitness update");
    final FitnessUpdate testFitnessUpdate = testFitnessUpdateModel;

    test('should check whether or not the device is connected to the internet',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      fitnessUpdateRepositoryImpl.saveFitnessUpdate(testFitnessUpdate);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return the fitnessUpdate saved when we successfully save the fitnessUpdate to Firestore',
          () async {
        // arrange
        // note that we are using thenAnswer instead of thenReturn here because the function is asychronous
        when(fitnessUpdateRepositoryImpl.saveFitnessUpdate(any))
            .thenAnswer((_) async => Right(testFitnessUpdate));
        // act
        final result =
            fitnessUpdateRepositoryImpl.saveFitnessUpdate(testFitnessUpdate);
        // assert
        verify(
            fitnessUpdateRepositoryImpl.saveFitnessUpdate(testFitnessUpdate));
        expect(result, Right(testFitnessUpdate));
      });

      test(
          'should return Failure when the saveFitnessUpdate method does not complete successfully',
          () async {
        // arrange
        when(mockRemoteDataSource.saveFitnessUpdate(any))
            .thenThrow(ServerException());
        // act
        final result =
            mockRemoteDataSource.saveFitnessUpdate(testFitnessUpdateModel);
        // assert
        expect(result, Left(ServerFailure));
      });
    });
  });
}
