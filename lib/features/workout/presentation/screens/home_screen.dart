import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/features/workout/data/models/user_model.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:blobs/blobs.dart' as BlobPackage;

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  String inscribeInitials(String name) {
    String res = "";
    name.split(" ");
    res += name.substring(0, 1);
    int index = name.indexOf(" ");
    res += name.substring(index + 1, index + 2);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserModel>(context);
    String userInitials = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                // color: Color(0xFFF8C8DC),
                // color: Color(0xFF8ACFff),
                // color: Color(0xFF966ED5),
                color: Color(0xFFFF8244),
                // color: Color(0xFFFFCA4B),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
              ),
              height: size.height * .35,
              child: Stack(
                children: [
                  Positioned(
                    left: -size.width * 0.30,
                    top: -size.height * 0.21,
                    child: BlobPackage.Blob.fromID(
                      id: ['8-6-59694'],
                      size: size.height * 0.5,
                      styles: BlobPackage.BlobStyles(
                        color: Color(0xFF966ED5),
                        // color: Color(0xFF8ACFff),
                        // color: Color(0xFFF8C8DC),
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
                        print("profile tapped");
                      },
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.15,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: user.profilePicture.isEmpty
                              ? Text(
                                  userInitials,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: user.profilePicture,
                                  ),
                                ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF966ED5),
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
                        color: Color(0xFF966ED5),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Color(0xFF966ED5),
                                child: Icon(
                                  Icons.local_fire_department_sharp,
                                  color: Colors.white,
                                  size: size.height * 0.05,
                                ),
                              ),
                            ),
                            Text(user.caloriesBurned.toStringAsFixed(0)),
                            Text("calories"),
                          ]),
                          SizedBox(
                            width: size.width * 0.09,
                          ),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Color(0xFF966ED5),
                                  child: Icon(
                                    Icons.timer_sharp,
                                    color: Colors.white,
                                    size: size.height * 0.05,
                                  ),
                                ),
                              ),
                              Text(user.totalWorkoutTime.toStringAsFixed(0)),
                              Text("Hours")
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
                                  color: Color(0xFF966ED5),
                                  child: Icon(
                                    Icons.timeline_sharp,
                                    color: Colors.white,
                                    size: size.height * 0.05,
                                  ),
                                ),
                              ),
                              Text(user.level.toString()),
                              Text("Level")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        radius: 11,
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
                                    SizedBox(
                                      width: size.width * 0.06,
                                    ),
                                    Column(
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
                                                DateFormat('yyyy-MM-dd').format(
                                                    updateList[index].dateTime),
                                              ),
                                            ),
                                            Icon(
                                              Icons.circle,
                                              size: 7,
                                              color:
                                                  Theme.of(context).shadowColor,
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
                                              color:
                                                  Theme.of(context).shadowColor,
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
          ]),
        ),
      ),
      drawer: DetailDrawer(context),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
    );
  }
}
