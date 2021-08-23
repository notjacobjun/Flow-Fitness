import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/presentation/provider/fitness_update_list.dart';
import 'package:interactive_workout_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

import 'features/social/presentation/screens/guild_detail_screen.dart';
import 'features/social/presentation/screens/no_guild_screen.dart';
import 'features/workout/data/models/fitness_update_model.dart';
import 'features/workout/presentation/screens/awards_screen.dart';
import 'features/workout/presentation/screens/home_screen.dart';
import 'features/workout/presentation/screens/login_screen.dart';
import 'features/workout/presentation/screens/registration_screen.dart';
import 'features/workout/presentation/screens/rest_screen.dart';
import 'features/workout/presentation/screens/results_screen.dart';
import 'features/workout/presentation/screens/settings_screen.dart';
import 'features/workout/presentation/screens/welcome_screen.dart';
import 'features/workout/presentation/screens/workout_categories_screen.dart';
import 'features/workout/presentation/screens/workout_screen.dart';
import 'features/workout/presentation/provider/workout_category.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
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
        ChangeNotifierProvider<FitnessUpdateModel>(
          create: (context) => FitnessUpdateModel(
              caloriesBurned: 0,
              dateTime: DateTime.now(),
              id: '',
              totalWorkoutTime: 0,
              workoutTitle: ''),
        ),
        StreamProvider<List<FitnessUpdateModel>>(
          create: (_) => di.sl<FitnessUpdateList>().streamOfFitnessUpdates(),
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
