import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_workout_app/services/guild_service.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGuildService extends Mock implements GuildService {}

class MockUserService extends Mock implements UserService {}

void main() {
  MockFirebaseAuth mockFirebaseAuth;
  MockGuildService mockGuildService;
  MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
    mockGuildService = MockGuildService();
    mockFirebaseAuth = MockFirebaseAuth();
  });

  final User mockUser = mockFirebaseAuth.currentUser;
  test('should level up user when surpasses the previous level barrier',
      () async {
    // arrange
    when(mockUserService.updateUsersDB(20))
        .thenAnswer((_) async => tNumberTriviaModel);
    // act
    final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
    // assert
    verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
    expect(result, equals(Right(tNumberTrivia)));
  });
}
