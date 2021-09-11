import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/components/onboard/welcome/rounded_button.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/data/models/user_model.dart';
import 'package:interactive_workout_app/features/workout/presentation/widgets/fitness_chart.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:blobs/blobs.dart' as BlobPackage;

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFF8244),
                ),
                height: size.height * .35,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      left: -size.width * 0.30,
                      top: -size.height * 0.21,
                      child: BlobPackage.Blob.fromID(
                        id: ['8-6-59694'],
                        size: size.height * 0.5,
                        styles: BlobPackage.BlobStyles(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.05,
                      top: size.height * 0.08,
                      child: Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.12,
                      left: size.width * 0.05,
                      child: user.name.isEmpty
                          ? Text(
                              "Hello!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).indicatorColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                            )
                          : Text(
                              "Hello, " + user.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).indicatorColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                    Positioned(
                      right: size.width * 0.03,
                      top: size.height * 0.05,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      RoundedButton(
                                        message: "Sign out",
                                        color: Theme.of(context).hintColor,
                                        function: signOut,
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.15,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: user.profilePicture.isEmpty
                                ? Text(
                                    user.name.substring(0, 1),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      height: size.height * 0.07,
                                      fit: BoxFit.cover,
                                      imageUrl: user.profilePicture,
                                    ),
                                  ),
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: size.width * -0.09,
                      bottom: size.height * -0.12,
                      child: Container(
                        height: size.height * 0.25,
                        width: size.width * 0.25,
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: size.height * 0.02,
                      left: size.width * 0.05,
                      child: Container(
                        height: size.height * 0.13,
                        width: size.width * 0.9,
                        padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            top: size.height * 0.01,
                            right: size.width * 0.03),
                        decoration: BoxDecoration(
                            color: Theme.of(context).indicatorColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Theme.of(context).shadowColor,
                                  child: Icon(
                                    Icons.local_fire_department_sharp,
                                    color: Colors.white,
                                    size: size.height * 0.05,
                                  ),
                                ),
                              ),
                              Text(
                                user.caloriesBurned.toStringAsFixed(1),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "calories",
                                style: TextStyle(fontSize: 16),
                              ),
                            ]),
                            SizedBox(
                              width: size.width * 0.09,
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Theme.of(context).shadowColor,
                                    child: Icon(
                                      Icons.timer_sharp,
                                      color: Colors.white,
                                      size: size.height * 0.05,
                                    ),
                                  ),
                                ),
                                Text(
                                  (user.totalWorkoutTime / 60)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Hours",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              width: size.width * 0.09,
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Theme.of(context).shadowColor,
                                    child: Icon(
                                      Icons.timeline_sharp,
                                      color: Theme.of(context).indicatorColor,
                                      size: size.height * 0.05,
                                    ),
                                  ),
                                ),
                                Text(
                                  user.level.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Level",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "My Activity:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Container(
              height: size.height * 0.20,
              width: size.width,
              child: FitnessChart(),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Recent Workouts",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              height: size.height * 0.32,
              child: Consumer<List<FitnessUpdateModel>>(
                builder: (context, updateList, child) {
                  return updateList.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.all(7.0),
                          itemCount: updateList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: size.height * 0.09,
                              width: size.width,
                              child: Card(
                                key: Key(updateList[index].id),
                                elevation: 4,
                                borderOnForeground: true,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: CircleAvatar(
                                        radius: 7,
                                        backgroundColor:
                                            updateList[index].caloriesBurned >=
                                                    200
                                                ? Colors.red.shade400
                                                : updateList[index]
                                                            .caloriesBurned >=
                                                        100
                                                    ? Colors.orange.shade400
                                                    : Colors.green.shade400,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              updateList[index].workoutTitle,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(updateList[index]
                                                          .dateTime),
                                                ),
                                              ),
                                              Icon(
                                                Icons.circle,
                                                size: 7,
                                                color: Theme.of(context)
                                                    .shadowColor,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  updateList[index]
                                                          .caloriesBurned
                                                          .toStringAsFixed(1) +
                                                      " Calories",
                                                ),
                                              ),
                                              Icon(
                                                Icons.circle,
                                                size: 7,
                                                color: Theme.of(context)
                                                    .shadowColor,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  (updateList[index]
                                                                  .totalWorkoutTime /
                                                              60)
                                                          .toStringAsFixed(1) +
                                                      " Minutes",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
          ]),
        ),
      ),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
    );
  }
}
