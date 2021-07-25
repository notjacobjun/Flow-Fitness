import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:interactive_workout_app/core/errors/expetions.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockFirebaseFireStore extends Mock implements FirebaseFirestore {}

// need to add these three mocks here because Mockito doesn't understand these types by default
class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  FitnessUpdateRemoteDataSourceImpl remoteDataSourceImpl;
  MockHttpClient mockHttpClient;
  MockFirebaseFireStore mockFirebaseFireStore;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference mockDocumentReference;
  MockDocumentSnapshot mockDocumentSnapshot;
  // final mockFitnessUpdateModel = FitnessUpdateModel(
  //   workoutTitle: "test fitness update model workout",
  //   totalWorkoutTime: 20,
  //   caloriesBurned: 40.22,
  //   dateTime: DateTime.parse("2021-07-16 21:51:53.092"),
  // );
  final mockFitnessUpdateModel =
      FitnessUpdateModel.fromJson(json.decode(fixture("fitness_update.json")));
  setUp(() {
    mockHttpClient = MockHttpClient();
    mockFirebaseFireStore = MockFirebaseFireStore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();
    remoteDataSourceImpl =
        FitnessUpdateRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMocksForFirestore() {
    // when(mockFirebaseFireStore.collection(any))
    //     .thenReturn(mockCollectionReference);
    when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
    when(mockDocumentReference.get())
        .thenAnswer((_) async => mockDocumentSnapshot);
  }

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('fitness_update.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group("getAllFitnessUpdates", () {
    test('should fetch all the fitness updates of the current user', () async {
      // arrange
      // act
      remoteDataSourceImpl.getAllFitnessUpdates();
      // assert
    });

    test(
        'should return a FitnessUpdate when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await remoteDataSourceImpl.getAllFitnessUpdates();
      // assert
      expect(result, mockFitnessUpdateModel);
    });

    test(
        'should throw a ServerException when the response code is 404 or other 400',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = remoteDataSourceImpl.getAllFitnessUpdates;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
