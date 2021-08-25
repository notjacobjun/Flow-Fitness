import 'package:flutter/material.dart';
import 'package:interactive_workout_app/features/workout/data/models/fitness_update_model.dart';
import 'package:interactive_workout_app/services/user_service.dart';
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

  Future<String> getUserName() async {
    UserService userService = UserService();
    final String name = await userService.getUserName();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(children: [
            // SizedBox(
            //   child: Container(
            //     color: Color(0xFF966ED5),
            //   ),
            //   height: size.height * 0.03,
            // ),
            Container(
              decoration: BoxDecoration(
                // color: Color(0xFF8ACFff),
                color: Color(0xFF966ED5),
                // color: Color(0xFFFFCA4B),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
              ),
              height: size.height * .35,
              child: Stack(
                // TODO configure this clip
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    left: -size.width * 0.30,
                    top: -size.height * 0.21,
                    child: BlobPackage.Blob.fromID(
                      id: ['8-6-59694'],
                      size: 400,
                      styles: BlobPackage.BlobStyles(
                        color: Color(0xFFFF8244),
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
                    child: FutureBuilder(
                        future: getUserName(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (!snapshot.hasData)
                            return Text(
                              "Welcome back",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).indicatorColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                            );
                          final String userName = snapshot.data;
                          return Column(
                            children: [
                              Text(
                                "Hello, $userName",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).indicatorColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                            ],
                          );
                        }),
                  ),
                  Positioned(
                    left: size.width * 0.2,
                    top: size.height * 0.2,
                    child: Container(
                      child: Column(
                        children: [],
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
