import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';
import 'package:interactive_workout_app/features/workout/domain/useCases/save_fitness_update.dart';
import 'package:mockito/mockito.dart';

class MockFitnessUpdateRepository extends Mock
    implements FitnessUpdateRepository {}

void main() {
  SaveFitnessUpdate useCase;
  FitnessUpdateRepository fitnessUpdateRepository;
  setUp(() {
    fitnessUpdateRepository = MockFitnessUpdateRepository();
    useCase = SaveFitnessUpdate(fitnessUpdateRepository);
  });

  // now we are setting up the mock object for the fitness update to be saved
  final FitnessUpdateModel testFitnessUpdate = FitnessUpdateModel(
      dateTime: DateTime(2020, 8, 21),
      caloriesBurned: 50,
      workoutTitle: "testWorkoutTitle",
      totalWorkoutTime: 20,
      id: "test fitness update");

  group("SaveFitnessUpdates to Firestore", () {
    test('should convert the fitnessUpdateInto a JSON format', () async {
      // arrange
      // TODO see which method we are suppsoed to call when setting this test up
      // act
      // assert
    });
  });
}
