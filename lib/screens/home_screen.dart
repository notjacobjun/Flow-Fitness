import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_app_bar.dart';
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
    final Widget svg = SvgPicture.asset("assets/images/ab_workout.svg");
    Size size = MediaQuery.of(context).size;
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
          ),
          Container(
            child: Image.asset("assets/images/ab_workout.png"),
            height: size.height * 0.65,
            width: size.width,
          ),
        ],
      ),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: RoundedAppBar(
        text: Text("Flow Fitness"),
      ),
      drawer: DetailDrawer(context),
    );
  }
}
