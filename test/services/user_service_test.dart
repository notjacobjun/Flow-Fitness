import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_workout_app/services/guild_service.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:mockito/mockito.dart';

class MockGuildService extends Mock implements GuildService {}

class MockUserService extends Mock implements UserService {}

void main() {
  FakeFirebaseFirestore mockFirebaseFireStore;
  MockFirebaseAuth mockFirebaseAuth;
  MockGuildService mockGuildService;
  MockUserService mockUserService;
  // creating a mock user
  final mockUser = MockUser(
    isAnonymous: false,
    uid: 'test',
    email: 'test@email.com',
    displayName: 'tester',
  );

  setUp(() async {
    mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    mockUserService = MockUserService();
    mockGuildService = MockGuildService();
    mockFirebaseFireStore = FakeFirebaseFirestore();
    // add the test user into the mock users collection
    await mockFirebaseFireStore.collection('users').add({
      // adding this is causing error
      "test": "test",
    });
    // set the field data for the user in the users collection
    await mockFirebaseFireStore.collection('users').doc('test').set({
      'caloriesBurned': 0,
      'level': 1,
    });
  });

  test('should return 51 as calories needed to reach level 4', () async {
    // act
    final result = mockUserService.nextLevel(3);
    // assert
    expect(result, 51);
  });

  test('should level up the user to level 4 when a new user burns 51 calories',
      () async {
    double mockCaloriesBurned = 51;
    double expectedLevel = 4;
    // arrange
    // return the mock user when the implementation calls for the user data
    when(mockFirebaseFireStore.collection(any).doc(any).get())
        .thenAnswer((_) async {
      return mockFirebaseFireStore.collection("users").doc(mockUser.uid).get();
    });
    // act
    mockUserService.updateUsersDB(mockCaloriesBurned);
    final res = await mockFirebaseFireStore.collection('users').get();
    // assert
    verify(mockFirebaseFireStore.collection('users').doc(any).get());
    expect(res.docs.first.get('level'), expectedLevel);
  });
}
