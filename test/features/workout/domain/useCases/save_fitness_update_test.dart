import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/save_fitness_update.dart';
import 'package:mockito/mockito.dart';

class MockFitnessUpdateRepository extends Mock
    implements FitnessUpdateRepository {}

void main() {
  SaveFitnessUpdate useCase;
  FitnessUpdateRepository mockFitnessUpdateRepository;
  setUp(() {
    mockFitnessUpdateRepository = MockFitnessUpdateRepository();
    useCase = SaveFitnessUpdate(mockFitnessUpdateRepository);
  });

  // now we are setting up the mock object for the fitness update to be saved
  final FitnessUpdateModel testFitnessUpdate = FitnessUpdateModel(
      dateTime: DateTime(2020, 8, 21),
      caloriesBurned: 50,
      workoutTitle: "testWorkoutTitle",
      totalWorkoutTime: 20,
      id: "test fitness update");

  group("SaveFitnessUpdates to Firestore", () {
    test('should save the fitness update by calling the Firestore API',
        () async {
      // arrange
      when(useCase.call(any)).thenAnswer((_) async => Right(testFitnessUpdate));
      // act
      final result = useCase(Params(fitnessUpdate: testFitnessUpdate));
      // assert
      expect(result, Right(testFitnessUpdate));
      verify(mockFitnessUpdateRepository.saveFitnessUpdate(testFitnessUpdate));
      verifyNoMoreInteractions(mockFitnessUpdateRepository);
    });
  });
}
