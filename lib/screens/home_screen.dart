import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart';
import 'package:interactive_workout_app/core/network/network_info.dart';
import 'package:interactive_workout_app/features/workout/data/dataSources/fitness_update_remote_data_source.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/data/repositories/fitness_update_repository_impl.dart';
import 'package:interactive_workout_app/features/workout/domain/entities/fitness_update.dart';
import 'package:interactive_workout_app/features/workout/domain/repositories/fitness_update_repository.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_app_bar.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Future<String> getUserName() async {
    UserService userService = UserService();
    final String name = await userService.getUserName();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
          Text(
            "My Activity:",
            style: TextStyle(fontSize: 18),
          ),
          GlassmorphicContainer(
            height: size.height * 0.25,
            width: size.width * 0.85,
            child: SfSparkLineChart(
              axisLineColor: Theme.of(context).accentColor,
              color: Theme.of(context).primaryColor,
              data: [2, 3, 0, 5, 6],
              labelDisplayMode: SparkChartLabelDisplayMode.high,
              trackball: SparkChartTrackball(
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50)),
            ),
            borderRadius: 50,
            blur: 200,
            alignment: Alignment.center,
            border: 0.65,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff).withOpacity(0.1),
                  Color(0xFFFFFFFF).withOpacity(0.05),
                ],
                stops: [
                  0.1,
                  1,
                ]),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.5),
                Color((0xFFFFFFFF)).withOpacity(0.5),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Recent Workouts",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Consumer<List<FitnessUpdateModel>>(
              builder: (context, updates, child) {
                return updates.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.all(7.0),
                        itemCount: updates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: size.height * 0.09,
                            width: size.width,
                            child: Card(
                              key: Key(updates[index].id),
                              elevation: 4,
                              borderOnForeground: true,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 11,
                                      backgroundColor: updates[index]
                                                  .caloriesBurned >=
                                              200
                                          ? Colors.red.shade400
                                          : updates[index].caloriesBurned >= 100
                                              ? Colors.orange.shade400
                                              : Colors.green.shade400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.06,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          updates[index].workoutTitle,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                  updates[index].dateTime),
                                            ),
                                          ),
                                          Icon(
                                            Icons.circle,
                                            size: 7,
                                            color:
                                                Theme.of(context).shadowColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              updates[index]
                                                      .caloriesBurned
                                                      .toStringAsPrecision(2) +
                                                  " Calories",
                                            ),
                                          ),
                                          Icon(
                                            Icons.circle,
                                            size: 7,
                                            color:
                                                Theme.of(context).shadowColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              updates[index]
                                                      .totalWorkoutTime
                                                      .toStringAsPrecision(2) +
                                                  " Minutes",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                            "Looks like you haven't worked out in the past 7 days"),
                      );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: RoundedAppBar(
        text: FutureBuilder(
            future: getUserName(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData)
                return Text(
                  "Welcome back",
                  overflow: TextOverflow.ellipsis,
                  // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                );
              final String userName = snapshot.data;
              return Column(
                children: [
                  Text(
                    "Welcome back $userName",
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              );
            }),
      ),
      drawer: DetailDrawer(context),
    );
  }
}
