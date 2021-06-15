import 'package:flutter/material.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';

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
    // final currentUserName = getUserName().toString();
    // print(currentUserName);
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              FutureBuilder(
                  future: getUserName(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData)
                      return Text(
                        "Welcome back!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      );
                    final String userName = snapshot.data;
                    return Column(
                      children: [
                        Text(
                          "Welcome back $userName",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    );
                  }),
            ],
          )
        ],
      ),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: AppBar(
        title: Text("Flow Fitness"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      drawer: DetailDrawer(context),
    );
  }
}
