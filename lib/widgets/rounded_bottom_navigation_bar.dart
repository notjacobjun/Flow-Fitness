import 'package:flutter/material.dart';
import 'package:interactive_workout_app/screens/awards_screen.dart';
import 'package:interactive_workout_app/screens/home_screen.dart';
import 'package:interactive_workout_app/screens/settings_screen.dart';
import 'package:interactive_workout_app/screens/social_screen.dart';
import 'package:interactive_workout_app/screens/workout_categories_screen.dart';

// TODO confiure to manage state properly because the current solution
// might not be keeping track of the state of each screen
// also sometimes the navigator doesn't switch
// ignore: must_be_immutable
class RoundedBottomNavigationBar extends StatefulWidget {
  var index;
  RoundedBottomNavigationBar({this.index});

  @override
  _RoundedBottomNavigationBarState createState() =>
      _RoundedBottomNavigationBarState();
}

class _RoundedBottomNavigationBarState
    extends State<RoundedBottomNavigationBar> {
  void selectTab(int selectedIndex) {
    setState(() {
      widget.index = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Theme.of(context).accentColor,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          onTap: selectTab,
          currentIndex: widget.index,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  if (widget.index != 0) {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }
                },
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.emoji_events),
                onPressed: () {
                  if (widget.index != 1) {
                    Navigator.of(context)
                        .pushReplacementNamed(AwardsScreen.routeName);
                  }
                },
              ),
              label: "Awards",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.fitness_center),
                onPressed: () {
                  if (widget.index != 2) {
                    Navigator.of(context).pushReplacementNamed(
                        WorkoutCategoriesScreen.routeName);
                  }
                },
              ),
              label: "Workout",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.chat_sharp),
                onPressed: () {
                  if (widget.index != 3) {
                    Navigator.of(context)
                        .pushReplacementNamed(SocialScreen.routeName);
                  }
                },
              ),
              label: "Social",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  if (widget.index != 4) {
                    Navigator.of(context)
                        .pushReplacementNamed(SettingsScreen.routeName);
                  }
                },
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
