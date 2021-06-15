import 'package:flutter/material.dart';
import 'package:interactive_workout_app/screens/no_guild_screen.dart';
import 'package:interactive_workout_app/services/user_service.dart';
import 'package:interactive_workout_app/widgets/detail_drawer.dart';
import 'package:interactive_workout_app/widgets/rounded_bottom_navigation_bar.dart';

class SocialScreen extends StatefulWidget {
  static const routeName = '/social';
  @override
  SocialScreenState createState() => SocialScreenState();
}

class SocialScreenState extends State<SocialScreen> {
  int _currentIndex = 3;
  final UserService userService = UserService();

  void checkForGuild() {
    // this is used to prevent the setState call during the build method
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userService.getGuild() == null) {
        Navigator.of(context).pushReplacementNamed(NoGuildScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkForGuild();
    return Scaffold(
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: _currentIndex,
      ),
      appBar: AppBar(
        title: Text("Social"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      drawer: DetailDrawer(context),
      body: Column(
        children: [],
      ),
    );
  }
}
