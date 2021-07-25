import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/core/errors/expetions.dart';
import 'package:interactive_workout_app/screens/awards_screen.dart';
import 'package:interactive_workout_app/screens/guild_detail_screen.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';
import 'package:interactive_workout_app/screens/login_screen.dart';
import 'package:interactive_workout_app/screens/no_guild_screen.dart';
import 'package:interactive_workout_app/screens/registration_screen.dart';
import 'package:interactive_workout_app/screens/rest_screen.dart';
import 'package:interactive_workout_app/screens/results_screen.dart';
import 'package:interactive_workout_app/screens/settings_screen.dart';
import 'package:interactive_workout_app/screens/welcome_screen.dart';
import 'package:interactive_workout_app/screens/workout_categories_screen.dart';
import 'package:interactive_workout_app/screens/workout_screen.dart';
import 'package:interactive_workout_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

import 'features/workout/data/models/fitness_update_model.dart';
import 'providers/workout_category.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider<List<FitnessUpdateModel>>(
          create: (_) => streamOfFitnessUpdates(),
          initialData: [],
          catchError: (_, error) {
            print(
                "error in the stream provider of fitness updates from Firestore: " +
                    error.toString());
            return [];
          },
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider<WorkoutCategory>(
          create: (_) => WorkoutCategory(),
        ),
        // ChangeNotifierProvider<WorkoutCategory>(create: WorkoutCategory()),
      ],
      child: MaterialApp(
        title: 'Flow Fitness',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.orange.shade900,
          primaryColorLight: Colors.deepOrangeAccent,
          accentColor: Colors.black,
          indicatorColor: Colors.white,
          textTheme: TextTheme().apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white),
          fontFamily: "Quicksand",
        ),
        routes: {
          '/': (ctx) => AuthenticationWrapper(),
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          WorkoutCategoriesScreen.routeName: (ctx) => WorkoutCategoriesScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          AwardsScreen.routeName: (ctx) => AwardsScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          WorkoutScreen.routeName: (ctx) => WorkoutScreen(),
          RestScreen.routeName: (ctx) => RestScreen(),
          ResultsScreen.routeName: (ctx) => ResultsScreen(),
          NoGuildScreen.routeName: (ctx) => NoGuildScreen(),
          GuildDetailScreen.routeName: (ctx) => GuildDetailScreen(),
        },
      ),
    );
  }

  // TODO make sure that this fits into the overall architecture of the app
  Stream<List<FitnessUpdateModel>> streamOfFitnessUpdates() {
    // goes into firestore and retrieves the fitness updates for the current user
    var ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('fitnessUpdates');
    if (ref.snapshots() == null) {
      print("Firestore returned null for user fitness updates");
    }
    ref.snapshots().forEach((element) {
      element.docs.forEach((doc) {
        print("updates from main.dart: " + doc.data().toString());
      });
    });
    return ref.snapshots().map((list) => list.docs
        .map((doc) => FitnessUpdateModel.fromMap(doc.data(), doc.id))
        .toList());
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // checks if a user is already logged in
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomeScreen();
    } else {
      return WelcomeScreen();
    }
  }
}
